import 'package:employees_attendance/constants/constance.dart';
import 'package:employees_attendance/models/attendanse_model.dart';
import 'package:employees_attendance/services/location_servese.dart';
import 'package:employees_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceServeses extends ChangeNotifier {
  final SupabaseClient _subapase = Supabase.instance.client;
  bool _isLoding = false;
  bool get isLoding => _isLoding;
  set setIsLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  AttendanceModel? attendanceModel;

  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String _monthAttendanceDate = DateFormat('MMMM yyyy').format(DateTime.now());
  get monthAttendanceDate => _monthAttendanceDate;
  set setMonthAttendanceDate(String value) {
    _monthAttendanceDate = value;
    notifyListeners();
  }

  Future getAttendanceTable() async {
    final List userData = await _subapase
        .from(Constance.attendanceTable)
        .select()
        .eq(
          'employee_id',
          _subapase.auth.currentUser!.id,
        )
        .eq('date', todayDate);
    if (userData.isNotEmpty) {
      attendanceModel = AttendanceModel.fromJson(userData.first);
    }

    notifyListeners();
  }

  Future addAttendanceToday(BuildContext context) async {
    Map? getLocation = await LocationServese().getLocation(context);
    if (getLocation != null) {
      if (attendanceModel?.checkin == null) {
        await _subapase.from(Constance.attendanceTable).insert({
          "employee_id": _subapase.auth.currentUser!.id,
          "date": todayDate,
          "chech_in": DateFormat("HH:mm").format(DateTime.now()),
          "check_in_location":getLocation,
        });
      } else if (attendanceModel?.checkout == null) {
        await _subapase
            .from(Constance.attendanceTable)
            .update({
              "chech_out": DateFormat("HH:mm").format(DateTime.now()),
              "check_out_location":getLocation
            })
            .eq(
              'employee_id',
              _subapase.auth.currentUser!.id,
            )
            .eq('date', todayDate);
      } else {
        Utils.showSnackBar("You have already ckecked out today !", context);
      }
      getAttendanceTable();
    }else{
      Utils.showSnackBar("Not able to get your location", context,color: Colors.redAccent);
      getAttendanceTable();
    }
  }

  Future<List<AttendanceModel>> getAttandanceModelForMonth() async {
    final List userData = await _subapase
        .from(Constance.attendanceTable)
        .select()
        .eq(
          'employee_id',
          _subapase.auth.currentUser!.id,
        )
        .textSearch('date', "'$monthAttendanceDate'", config: 'english')
        .order('created_at', ascending: false);

    print('----------------------');
    print(userData.map((att) => AttendanceModel.fromJson(att)).toList());
    return userData.map((att) => AttendanceModel.fromJson(att)).toList();
  }
}
