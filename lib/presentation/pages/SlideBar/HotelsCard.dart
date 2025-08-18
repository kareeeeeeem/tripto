import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc/Hotel/hotelBloc.dart';
import 'package:tripto/bloc/Hotel/hotelEvents.dart';
import 'package:tripto/bloc/Hotel/hotelStates.dart';
import 'package:tripto/presentation/pages/widget/HotelAdelPage.dart';
import 'package:tripto/presentation/pages/widget/PersonCounterWithPrice.dart';
import '../../../l10n/app_localizations.dart';

// دالة تحميل صورة الفندق من السيرفر
Future<Uint8List> fetchHotelImage(String imageUrl) async {
  final url = imageUrl.replaceFirst("/storage/", "/storage/app/public/");
  final response = await http.get(
    Uri.parse("https://tripto.blueboxpet.com$url"),
    headers: {
      // لو السيرفر يتطلب Authorization
      // 'Authorization': 'Bearer YOUR_TOKEN',
    },
  );
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception("Failed to load image");
  }
}

class HotelsDialog extends StatefulWidget {
  final int subDestinationId;
  final List<VoidCallback> nextSteps;
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey;
  final DateTime? startDate;
  final DateTime? endDate;

  const HotelsDialog({
    super.key,
    required this.subDestinationId,
    required this.nextSteps,
    this.personCounterKey,
    this.startDate,
    this.endDate,
  });

  @override
  State<HotelsDialog> createState() => _HotelsDialogState();
}

class _HotelsDialogState extends State<HotelsDialog> {
  int? selectedIndex;

  int getNumberOfDays() {
    if (widget.startDate != null && widget.endDate != null) {
      return widget.endDate!.difference(widget.startDate!).inDays + 1;
    }
    return 1;
  }

  @override
  void initState() {
    super.initState();
    context.read<HotelsBloc>().add(
      FetchHotels(subDestinationId: widget.subDestinationId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberOfDays = getNumberOfDays();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: BlocBuilder<HotelsBloc, HotelsState>(
          builder: (context, state) {
            if (state is HotelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelsError) {
              return Center(child: Text(state.message));
            } else if (state is HotelsLoaded) {
              final hotels = state.hotels;
              if (hotels.isEmpty)
                return Center(child: Text("No hotels available"));

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.hotel,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(6),
                      itemCount: hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = hotels[index];
                        final isSelected = selectedIndex == index;
                        final totalPrice = hotel.pricePerNight * numberOfDays;

                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.blue[50] : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child:
                                        (hotel.images.isNotEmpty &&
                                                hotel.images[0].isNotEmpty)
                                            ? FutureBuilder<Uint8List>(
                                              future: fetchHotelImage(
                                                hotel.images[0],
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (snapshot.hasError ||
                                                    !snapshot.hasData) {
                                                  return Image.asset(
                                                    "assets/images/Logo.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                } else {
                                                  return Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                  );
                                                }
                                              },
                                            )
                                            : Image.asset(
                                              "assets/images/Logo.png",
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            hotel.nameEn,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.info_outline,
                                            ),
                                            tooltip: "Details for hotel",
                                            onPressed: () {
                                              // الانتقال لصفحة HotelAdelPage مع تمرير بيانات الفندق
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => HotelAdelPage(
                                                        hotel: hotel,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        hotel.descriptionEn,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text("⭐ ${hotel.rate}"),
                                      Text(
                                        "Price per day: \$${hotel.pricePerNight.toStringAsFixed(2)}",
                                      ),
                                      Text(
                                        "Total: \$${totalPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed:
                                selectedIndex != null
                                    ? () {
                                      final hotel =
                                          state.hotels[selectedIndex!];
                                      widget.personCounterKey?.currentState
                                          ?.setSelectedHotelPrice(
                                            hotel.pricePerNight,
                                          );
                                      Navigator.pop(context, hotel);
                                      if (widget.nextSteps.isNotEmpty)
                                        widget.nextSteps.first();
                                    }
                                    : null,
                            child: Text(AppLocalizations.of(context)!.finish),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, null),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Cancel Hotel"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
