class AttendanceModel {
  final String id;
  final String date;
  final String checkin;
  final String? checkout;
  final DateTime createAt;
  final Map? checkInLocation;
  final Map? checkOutLocation;
  const AttendanceModel(
      {required this.id,
      required this.createAt,
      required this.checkin,
      this.checkout,
      required this.date,
      this.checkInLocation,
      this.checkOutLocation});
  factory AttendanceModel.fromJson(Map<String, dynamic> data) {
    return AttendanceModel(
        id: data['employee_id'],
        createAt: DateTime.parse(data['created_at']),
        date: data['date'],
        checkin: data['chech_in'],
        checkout: data['chech_out'],
        checkInLocation:data['check_in_location'],
        checkOutLocation:data['check_out_location'],
        
        );

  }
}
