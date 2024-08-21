import "package:employees_attendance/screens/attendance_screen.dart";
import "package:employees_attendance/screens/calender_screen.dart";
import "package:employees_attendance/screens/profile_screen.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navIcon = [
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.solidUser
  ];

  int _curantIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: IndexedStack(
        index: _curantIndex,
        
        children: const [
          CalenderScreen(),
                    AttendanceScreen(),

          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < navIcon.length; i++) ...{
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _curantIndex = i;
                    });
                  },
                  child: Center(
                    child: FaIcon(
                      navIcon[i],
                      color:
                          i == _curantIndex ? Colors.redAccent : Colors.black54,
                      size: _curantIndex == i ? 30 : 25,
                    ),
                  ),
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
