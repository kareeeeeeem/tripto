import 'package:flutter/material.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import '../../../l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/widget/PersonCounterWithPrice.dart';

class Hotels extends StatefulWidget {
  final List<GetTripModel> hotelTrips;
  final List<VoidCallback> nextSteps;
  final GlobalKey<PersonCounterWithPriceState>? personCounterKey;

  const Hotels({
    super.key,
    required this.hotelTrips,
    required this.nextSteps,
    this.personCounterKey,
  });

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  int? selectedHotelIndex;

  @override
  Widget build(BuildContext context) {
    final List<GetTripModel> tripsWithHotel = widget.hotelTrips;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height:
            MediaQuery.of(context).size.height * 0.7, // 70% من ارتفاع الشاشة
        child: Column(
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
                itemCount: tripsWithHotel.length,
                itemBuilder: (context, index) {
                  final hotel = tripsWithHotel[index];
                  final isSelected = selectedHotelIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedHotelIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[50] : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              hotel.videoUrl,
                              width: 100,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.image),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  "This is the description of the hotel.",
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.price}: \$${hotel.price}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                          selectedHotelIndex != null
                              ? () {
                                final selectedHotel =
                                    tripsWithHotel[selectedHotelIndex!];

                                // فقط عند الضغط على Finish يحدث السعر
                                widget.personCounterKey?.currentState
                                    ?.setSelectedHotelPrice(
                                      selectedHotel.price,
                                    );

                                Navigator.pop(context, selectedHotel);

                                if (widget.nextSteps.isNotEmpty) {
                                  final nextStep = widget.nextSteps.first;
                                  nextStep();
                                }
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF002E70),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.finish,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, null); // Cancel Hotel
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          233,
                          121,
                          113,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Cancel Hotel",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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
