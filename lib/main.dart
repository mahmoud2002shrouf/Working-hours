import "package:employees_attendance/screens/splach_screen.dart";
import "package:employees_attendance/services/attendance_serveses.dart";
import "package:employees_attendance/services/auth_service.dart";
import "package:employees_attendance/services/db_serveses.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:provider/provider.dart";
import "package:supabase_flutter/supabase_flutter.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => DbServeses()),
        ChangeNotifierProvider(create: (context) => AttendanceServeses()),
      ],
      child: MaterialApp(
           debugShowCheckedModeBanner: false,
          title: 'Employee Attendance',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:const  SplachScreen()),
    );
  }
}
