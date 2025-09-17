class OrderTripSearcMyTrips {
  final int? tripId;
  final int? userId;
  final int? subDestinationId;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;
  final int? persons;
  final String? totalPrice;
  final String? status;
  final String? note;
  final String? fromDate;
  final String? toDate;
  final int? hotelId;
  final int? carId;
  final int? activityId;
  final int? flyId;
  final String? hotelPrice;
  final String? carPrice;
  final String? activityPrice;

  OrderTripSearcMyTrips({
    this.tripId,
    this.userId,
    this.subDestinationId,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.persons,
    this.totalPrice,
    this.status,
    this.note,
    this.fromDate,
    this.toDate,
    this.hotelId,
    this.carId,
    this.activityId,
    this.flyId,
    this.hotelPrice,
    this.carPrice,
    this.activityPrice,
  });

  factory OrderTripSearcMyTrips.fromJson(Map<String, dynamic> json) {
    return OrderTripSearcMyTrips(
      tripId: json['trip_id'],
      userId: json['user_id'],
      subDestinationId: json['sub_destination_id'],
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      persons: json['persons'],
      totalPrice: json['total_price']?.toString(),
      status: json['status'],
      note: json['note'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      hotelId: json['hotel_id'],
      carId: json['car_id'],
      activityId: json['activity_id'],
      flyId: json['fly_id'],
      hotelPrice: json['hotel_price']?.toString(),
      carPrice: json['car_price']?.toString(),
      activityPrice: json['activity_price']?.toString(),
    );
  }
}
