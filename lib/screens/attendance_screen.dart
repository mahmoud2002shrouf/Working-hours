import 'package:employees_attendance/models/user_model.dart';
import 'package:employees_attendance/services/attendance_serveses.dart';
import 'package:employees_attendance/services/db_serveses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<SlideActionState> keys = GlobalKey<SlideActionState>();
  @override
  void initState() {
    Provider.of<AttendanceServeses>(context,listen: false).getAttendanceTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceServeses=Provider.of<AttendanceServeses>(context);
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const Text(
                "welconme",
                style: TextStyle(fontSize: 30, color: Colors.black54),
              )),
          Consumer<DbServeses>(builder: (context, db, child) {
            return FutureBuilder(
              future: db.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data!;

                  return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.name != '' ? user.name : '#${user.employeeId}',
                        style: const TextStyle(fontSize: 25),
                      ));
                }
                return const LinearProgressIndicator();
              },
            );
          }),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: const Text(
              "Today's status",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Check in ",
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                      ),
                     const SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        attendanceServeses.attendanceModel?.checkin ?? "--/--",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const  Text(
                        "Check Out ",
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                      ),
                     const SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        attendanceServeses.attendanceModel?.checkout ?? "--/--",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ))
                ],
              )),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat("dd MMMM yyyy").format(DateTime.now()),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat("hh:mm:ss a").format(DateTime.now()),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                );
              }),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Builder(
              builder: (context) {
                return SlideAction(
                  text: attendanceServeses.attendanceModel?.checkin==null? "Slide to check in": "Slide to check out",
                  textStyle:
                      const TextStyle(fontSize: 18, color: Colors.black54),
                  outerColor: Colors.white,
                  innerColor: Colors.redAccent,
                  key: keys,
                  onSubmit: ()async {
                   await attendanceServeses.addAttendanceToday(context);
                    keys.currentState!.reset();
                  },
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
