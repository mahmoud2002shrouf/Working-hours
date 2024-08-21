import 'package:employees_attendance/models/attendanse_model.dart';
import 'package:employees_attendance/services/attendance_serveses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final attendansServeses = Provider.of<AttendanceServeses>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, top: 60, bottom: 10),
          child: const Text(
            'Attendance',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              attendansServeses.monthAttendanceDate,
              style: const TextStyle(fontSize: 25),
            ),
            OutlinedButton(
                onPressed: () async {
                  final selectDate =
                      await SimpleMonthYearPicker.showMonthYearPickerDialog(
                          context: context, disableFuture: true);
                  String formatDate =
                      DateFormat('MMMM yyyy').format(selectDate);
                  attendansServeses.setMonthAttendanceDate = formatDate;
                },
                child: const Text("Pick a month"))
          ],
        ),
        Expanded(
            child: FutureBuilder(
          future: attendansServeses.getAttandanceModelForMonth(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    AttendanceModel attendanceModel = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.only(
                          top: 12, bottom: 10, right: 20, left: 20),
                      height: 150,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 2))
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.redAccent),
                            child: Center(
                              child: Text(
                                DateFormat('EE \n dd')
                                    .format(attendanceModel.createAt),
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Check in",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 80,
                                child: Divider(),
                              ),
                              Text(attendanceModel.checkin)
                            ],
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Check out",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 80,
                                child: Divider(),
                              ),
                              Text(attendanceModel.checkout??"--/--")
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  "No attendance for this month",
                  style: TextStyle(fontSize: 25),
                ));
              }
            }
            return const LinearProgressIndicator(
              color: Colors.grey,
              backgroundColor: Colors.white,
            );
          },
        ))
      ],
    ));
  }
}
