import "package:employees_attendance/screens/register_screen.dart";
import "package:employees_attendance/services/auth_service.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHight / 3,
            decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  'FAANG',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Employees Email ID"),
                      prefix: Icon(Icons.person),
                      border: OutlineInputBorder()),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Password"),
                      prefix: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<AuthService>(
                  builder: (context, value, child) {
                    return SizedBox(
                    width: double.infinity,
                    height: 60,
                    child:value.isLoding? const Center(child:  CircularProgressIndicator()) : ElevatedButton(
                        onPressed: () {
                          value.loginEmployees(_emailController.text, _passwordController.text, context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),),
                        
                  );
                  },
                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const RegisterScreen();
                  },));
                }, child: const Text('Are you new employees ? Regester now!'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
