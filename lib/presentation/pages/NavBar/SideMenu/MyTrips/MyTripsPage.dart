import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/bloc&repo/OrderTrip/order_trip_bloc.dart';
import 'package:tripto/bloc&repo/OrderTrip/order_trip_repository.dart';
import 'package:tripto/bloc&repo/OrderTrip/order_trip_state.dart';
import 'package:tripto/bloc&repo/OrderTrip/order_trip_event.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/MyTrips/TripDetailsPage.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final storedUserId = await _storage.read(key: 'userId');
    print("✅ Stored userId: $storedUserId");

    if (storedUserId != null && storedUserId.isNotEmpty) {
      setState(() {
        userId = int.tryParse(storedUserId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BlocProvider(
      create: (context) =>
          OrderTripSearcMyTripsBloc(OrderTripSearcMyTripsRepository())
            ..add(FetchUserTrips(userId!)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.mytrips,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SideMenu()),
                (route) => false,
              );
            },
            icon: Icon(
              Localizations.localeOf(context).languageCode == 'ar'
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_left_outlined,
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
        body: BlocBuilder<OrderTripSearcMyTripsBloc, OrderTripSearcMyTripsState>(
          builder: (context, state) {
            if (state is OrderTripSearcMyTripsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderTripSearcMyTripsLoaded) {
              final trips = state.trips;

              if (trips.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.noTrips),
                );
              }

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  MediaQuery.of(context).size.height * 0.1,
                  MediaQuery.of(context).size.width * 0.02,
                  0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 241, 241),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.flight_takeoff,
                            color: Color(0xFF002E70),
                            size: 30,
                          ),
                          title: Text(
                            "${AppLocalizations.of(context)!.tripNumber} ${trip.tripId}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("${AppLocalizations.of(context)!.name}: ${trip.customerName ?? '-'}"),                           
                              Text("${AppLocalizations.of(context)!.fromDate}: ${trip.fromDate ?? '-'}"),
                              //Text("${AppLocalizations.of(context)!.persons}: ${trip.persons ?? '-'}"),
                              Text("${AppLocalizations.of(context)!.toDate}: ${trip.toDate ?? '-'}"),                          
                              Text("${AppLocalizations.of(context)!.totalPrice}: ${trip.totalPrice ?? '-'}"),
                              Text(
                                "${AppLocalizations.of(context)!.status}: ${getStatusLabel(trip.status, context)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: getStatusColor(trip.status), // ✅ هنا بنستعمل الألوان
                                ),
                              ),






                            ],
                          ),
                          trailing: Icon(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? Icons.keyboard_arrow_left
                                : Icons.keyboard_arrow_right,
                          ),
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripDetailsPage(trip: trip),
                                ),
                              );
                            },

                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is OrderTripSearcMyTripsError) {
              return Center(child: Text("${AppLocalizations.of(context)!.error}: ${state.message}"));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }// خارج الـ Widget:
String getStatusLabel(String? status, BuildContext context) {
  switch (status) {
    case 'pending':
      return AppLocalizations.of(context)!.pending;
    case 'confirmed':
      return AppLocalizations.of(context)!.confirmed;
    case 'canceled':
      return AppLocalizations.of(context)!.canceled;
    default:
      return "-";
  }
}

Color getStatusColor(String? status) {
  switch (status) {
    case 'pending':
      return Colors.orange;   // انتظار
    case 'confirmed':
      return Colors.green;    // مؤكد
    case 'canceled':
      return Colors.red;      // ملغي
    default:
      return Colors.black;    // في حالة غير معروف
  }
}

}