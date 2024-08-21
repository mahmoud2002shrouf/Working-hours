import 'package:employees_attendance/services/db_serveses.dart';
import 'package:employees_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final DbServeses _dbServes=DbServeses();
  bool _isLoding = false;
  bool get isLoding => _isLoding;
  set setIsLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  Future<void> regesterEmployees(
      String email, String password, BuildContext context) async {
    try {
      setIsLoding = true;
      if (email == "" || password == "") {
        throw ('All Fieds is required');
      }

      final AuthResponse res =
          await _supabase.auth.signUp(password: password, email: email);
      // ignore: unnecessary_null_comparison
      if (res != null) {
        await _dbServes.insertNewUser(email, res.user!.id);
        Utils.showSnackBar('Success Regester !', context,
            color: Colors.green);
        await loginEmployees(email, password, context);
        Navigator.pop(context);
      }
    } catch (err) {
      setIsLoding = false;
      Utils.showSnackBar(err.toString(), context, color: Colors.red);
    }
  }

  Future<void> loginEmployees(
      String email, String password, BuildContext context) async {
    try {
      setIsLoding = true;
      if (email == "" || password == "") {
        throw ('All Fieds is required');
      }

      final AuthResponse res = await _supabase.auth
          .signInWithPassword(password: password, email: email);
      print("ressss: ${res.session}");
      Utils.showSnackBar('Success  login', context, color: Colors.green);
      setIsLoding = false;
    } catch (err) {
      setIsLoding = false;
      Utils.showSnackBar(err.toString(), context, color: Colors.red);
    }
  }

  Future<void> logoutEmployees(BuildContext context) async {
    try {
      setIsLoding = true;
      await _supabase.auth.signOut();
      _dbServes.usermodel=null;
      _dbServes.userDepartmeant=null;
      notifyListeners();
      Utils.showSnackBar('Success  logout', context, color: Colors.green);
      setIsLoding = false;
    } catch (err) {
      setIsLoding = false;
      Utils.showSnackBar('Logout faild', context, color: Colors.red);
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
}
