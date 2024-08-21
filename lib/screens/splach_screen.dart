import 'package:employees_attendance/screens/home_screen.dart';
import 'package:employees_attendance/screens/login_screen.dart';
import 'package:employees_attendance/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return auth.currentUser == null ? const LoginScreen() : const HomeScreen();
  }
}
