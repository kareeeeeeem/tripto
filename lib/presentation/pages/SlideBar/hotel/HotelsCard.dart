import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/Hotel/hotelBloc.dart';
import 'package:tripto/bloc&repo/Hotel/hotelEvents.dart';
import 'package:tripto/bloc&repo/Hotel/hotelStates.dart';
import 'package:tripto/bloc&repo/SearchHotel/hotelSearchEvents.dart';
import 'package:tripto/bloc&repo/SearchHotel/hotelSearchBloc.dart';
import 'package:tripto/bloc&repo/SearchHotel/hotelSearchStates.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/SlideBar/hotel/HoteleDetailsPage.dart';
import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../l10n/app_localizations.dart';

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
  final int? selectedHotelId; 

  const HotelsDialog({
    super.key,
    required this.subDestinationId,
    required this.nextSteps,
    this.personCounterKey,
    this.startDate,
    this.endDate,
    this.selectedHotelId, 
  });

  @override
  State<HotelsDialog> createState() => _HotelsDialogState();
}



class _HotelsDialogState extends State<HotelsDialog> {
  int? selectedIndex;
  late HotelsSearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = HotelsSearchBloc(); // Bloc منفصل للبحث
    context.read<HotelsBloc>().add(
      FetchHotels(subDestinationId: widget.subDestinationId),
    );
    if (widget.selectedHotelId != null) {
      selectedIndex = null;
    }
  }

  int getNumberOfNights() {
    if (widget.startDate != null && widget.endDate != null) {
      final start = DateTime(
        widget.startDate!.year,
        widget.startDate!.month,
        widget.startDate!.day,
      );
      final end = DateTime(
        widget.endDate!.year,
        widget.endDate!.month,
        widget.endDate!.day,
      );
      final diff = end.difference(start).inDays;
      return diff > 0 ? diff : 1;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final numberOfNights = getNumberOfNights();

    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.hotel,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned( 
                    right: 0, 
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: "Search Hotels",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String searchQuery = "";
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(AppLocalizations.of(context)!.search),
                              content: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enterHotelName,
                                ),
                                onChanged: (value) => searchQuery = value,
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    searchBloc.add(SearchHotelsByName(
                                      query: value,
                                      subDestinationId: widget.subDestinationId,
                                    ));
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              actions: [
                                  TextButton(
                                  onPressed: () {
                                    if (searchQuery.isNotEmpty) {
                                      searchBloc.add(
                                        SearchHotelsByName(
                                          query: searchQuery,
                                          subDestinationId: widget.subDestinationId,
                                        ),
                                      );
                                    }
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF002E70), // أزرق داكن للخلفية
                                    foregroundColor: Colors.white, // لون النص أبيض
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.search,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300, // خلفية رمادية فاتحة
                                      foregroundColor: Colors.black, // نص أسود
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                    
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Expanded للقائمة
            Expanded(
              child: BlocBuilder<HotelsSearchBloc, HotelsSearchState>(
                bloc: searchBloc,
                builder: (context, searchState) {
                  if (searchState is HotelsSearchLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  List hotelsToShow = [];
                  if (searchState is HotelsSearchLoaded) {
                    hotelsToShow = searchState.hotels;
                  } else if (searchState is HotelsSearchInitial ||
                      searchState is HotelsSearchError) {
                    final stateBloc = context.watch<HotelsBloc>().state;
                    if (stateBloc is HotelsLoaded) {
                      hotelsToShow = stateBloc.hotels;
                    }
                  }

                  if (hotelsToShow.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "No hotels found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF002E70), // خلفية كحلي
                              foregroundColor: Colors.white, // لون النص أبيض
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              const phoneNumber = '201028476944';
                              final message = Uri.encodeComponent(
                                AppLocalizations.of(context)!.customTripMessage,
                              );
                              final url = 'https://wa.me/$phoneNumber?text=$message';

                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!.cannotOpenWhatsapp,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.customtrip),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(11),
                    itemCount: hotelsToShow.length,
                    itemBuilder: (context, index) {
                      final hotel = hotelsToShow[index];
                      final isSelected = selectedIndex == index;
                      final totalPrice =
                          hotel.pricePerNight * numberOfNights;

                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical:15 ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[50] : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: (hotel.images.isNotEmpty &&
                                          hotel.images[0].isNotEmpty)
                                      ? Image.network(
                                          hotel.images[0],
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Image.asset(
                                                  "assets/images/Logo.png"),
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) return child;
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'ar'
                                              ? hotel.nameAr
                                              : hotel.nameEn,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                    ],
                                    ),
                                    
                                    const SizedBox(height: 4),
                                    Text(
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'ar'
                                          ? hotel.descriptionAr
                                          : hotel.descriptionEn,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(7, (i) {
                                        return Icon(
                                          i < hotel.rate
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                    Text(
                                      "${AppLocalizations.of(context)!.forNight} \$${hotel.pricePerNight.toStringAsFixed(2)}",
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.totalTrip(
                                        numberOfNights.toString(),
                                        totalPrice.toStringAsFixed(2),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                        
                                        //MediaQuery.of(context) .size.width *  0.035,
                                      
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                     ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // تقليل الحواف
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                            backgroundColor: const Color(0xFF002E70),

                                        minimumSize: const Size(122, 22), // أبعاد ثابتة للزر
                                      ),
                                      onPressed: () {
                                        final videoPlayerState = videoPlayerScreenKey.currentState;
                                        videoPlayerState?.pauseCurrentVideo();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => HotelAdelPage(hotel: hotel),
                                          ),
                                        ).then((_) {
                                          videoPlayerState?.playCurrentVideo();
                                        });
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children:  [
                                         
                                          SizedBox(height: 2),
                                          Text(
                                            AppLocalizations.of(context)!.infoHotel, // المفتاح في ملف ARB
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12, // حجم أصغر للنص
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
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
                  );
                },
              ),
            ),

            // أزرار Continue / Cancel
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: selectedIndex != null
                          ? () {
                              final stateBloc =
                                  context.read<HotelsBloc>().state;
                              if (stateBloc is HotelsLoaded) {
                                final hotel =
                                    stateBloc.hotels[selectedIndex!];
                                widget.personCounterKey?.currentState
                                    ?.setSelectedHotelPrice(
                                  hotel.pricePerNight,
                                  numberOfNights,
                                );
                                Navigator.pop(context, hotel);
                                if (widget.nextSteps.isNotEmpty) {
                                  widget.nextSteps.first();
                                }
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF002E70),
                        foregroundColor: Colors.white,
                      ),
                      child:
                          Text(AppLocalizations.of(context)!.continueButton),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.personCounterKey?.currentState
                            ?.setSelectedHotelPrice(0, 1);
                        Navigator.pop(context, null);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(AppLocalizations.of(context)!.cancelHotel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
