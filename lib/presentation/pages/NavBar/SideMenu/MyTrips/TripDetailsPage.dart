import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';

class TripDetailsPage extends StatefulWidget {
  final dynamic trip;

  const TripDetailsPage({super.key, required this.trip});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.tripDetails,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF002E70),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.person,
                AppLocalizations.of(context)!.name, trip.customerName),
            _buildDetailRow(Icons.phone,
                AppLocalizations.of(context)!.phone, trip.customerPhone),
            _buildDetailRow(Icons.date_range,
                AppLocalizations.of(context)!.fromDate, trip.fromDate),
            _buildDetailRow(Icons.date_range,
                AppLocalizations.of(context)!.toDate, trip.toDate),
            _buildDetailRow(Icons.group,
                AppLocalizations.of(context)!.persons, trip.persons),
            _buildDetailRow(Icons.flight,
                AppLocalizations.of(context)!.flyId, trip.flyId),
            _buildDetailRow(Icons.hotel,
                AppLocalizations.of(context)!.hotelPrice, trip.hotelPrice),
            _buildDetailRow(Icons.directions_car,
                AppLocalizations.of(context)!.carPrice, trip.carPrice),
            _buildDetailRow(Icons.local_activity,
                AppLocalizations.of(context)!.activityPrice, trip.activityPrice),
            _buildDetailRow(Icons.note,
                AppLocalizations.of(context)!.note, trip.note),
            _buildDetailRow(Icons.attach_money,
                AppLocalizations.of(context)!.totalPrice, trip.totalPrice),
            _buildStatusRow(trip.status, context),

          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF002E70), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: ${value ?? '-'}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildStatusRow(String? status, BuildContext context) {
  final icon = getStatusIcon(status);
  final color = getStatusColor(status);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22), // 🎯 الأيقونة حسب الحالة
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "${AppLocalizations.of(context)!.status}: ${getStatusLabel(status, context)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color, // نفس اللون بتاع الحالة
            ),
          ),
        ),
      ],
    ),
  );
}

IconData getStatusIcon(String? status) {
  switch (status) {
    case 'pending':
      return Icons.hourglass_empty; // ⏳ انتظار
    case 'confirmed':
      return Icons.check_circle; // ✅ مؤكد
    case 'canceled':
      return Icons.cancel; // ❌ ملغي
    default:
      return Icons.help; // ❓ غير معروف
  }
}

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
      return Colors.orange;
    case 'confirmed':
      return Colors.green;
    case 'canceled':
      return Colors.red;
    default:
      return Colors.black;
  }
}


}
