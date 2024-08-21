
import 'package:employees_attendance/models/departmeant_model.dart';
import 'package:employees_attendance/services/auth_service.dart';
import 'package:employees_attendance/services/db_serveses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbserviese = Provider.of<DbServeses>(context);
    dbserviese.allDepatmeant.isEmpty ? dbserviese.getAllDepartmeant() : null;
    nameController.text.isEmpty
        ? nameController.text = dbserviese.usermodel!.name 
        : null;

    return Scaffold(
        body: dbserviese.usermodel == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () {
                              context.read<AuthService>().logoutEmployees(context);
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text("Sign Out")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.redAccent),
                        child: const Center(
                          child:  Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Employee ID : ${dbserviese.usermodel!.employeeId}"),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            label: Text('Full name'),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      dbserviese.allDepatmeant.isEmpty
                          ? const LinearProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                  onChanged: (value) {
                                    print(
                                        "---------------------------------depr");
                                    print(value);
                                    dbserviese.userDepartmeant = value;
                                    print(dbserviese.userDepartmeant);
                                  },
                                  items: dbserviese.allDepatmeant
                                      .map((DepartmeantModel item) {
                                    return DropdownMenuItem(
                                        value: item.id,
                                        child: Text(
                                          item.title,
                                          style: const TextStyle(fontSize: 20),
                                        ));
                                  }).toList(),
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  value: dbserviese.userDepartmeant ??
                                      dbserviese.allDepatmeant.first.id),
                            ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: const BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1)))),
                            onPressed: () {
                              dbserviese.updateProfile(
                                  nameController.text, context);
                            },
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
              ));
  }
}
