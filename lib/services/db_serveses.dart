import 'dart:math';

import 'package:employees_attendance/constants/constance.dart';
import 'package:employees_attendance/models/departmeant_model.dart';
import 'package:employees_attendance/models/user_model.dart';
import 'package:employees_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbServeses extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<DepartmeantModel> allDepatmeant = [];
  int? userDepartmeant;
  UserModel? usermodel;
  String genarateId() {
    final random = Random();
    const allChart = 'qwertyuioplkjhgfdsazxvcbnm1230456789';
    final randomString =
        List.generate(8, (index) => allChart[random.nextInt(allChart.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constance.employeesTable).insert({
      'id': id,
      'name': "",
      "email": email,
      "departmeant": null,
      "employee_id": genarateId()
    });
  }

  Future<UserModel> getUserData() async {
    final userdata = await _supabase
        .from(Constance.employeesTable)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();

    usermodel = UserModel.fromJson(userdata);
    userDepartmeant == null
        ? userDepartmeant = usermodel!.department 
        : null;

    return usermodel!;
  }

  Future getAllDepartmeant() async {
    final List allDept =
        await _supabase.from(Constance.departmeantsTable).select();

    allDepatmeant = allDept.map((e) => DepartmeantModel.fromJson(e)).toList();
    notifyListeners();
  }

  Future updateProfile(String name, BuildContext context) async {
    try {
      print("----------------depta");
      print(userDepartmeant);
      await _supabase
          .from(Constance.employeesTable)
          .update({'departmeant':userDepartmeant, 'name': name}).eq(
              'id', _supabase.auth.currentUser!.id);
      Utils.showSnackBar('Update success', context, color: Colors.green);

      notifyListeners();
    } catch (err) {
      Utils.showSnackBar(err.toString(), context, color: Colors.redAccent);
    }
  }
}
