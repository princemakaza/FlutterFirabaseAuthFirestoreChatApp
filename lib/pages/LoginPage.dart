import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

import '../Components/MyTextField.dart';
import '../Components/myButton.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void SignIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.message,
                size: 100,
              ),
              const SizedBox(height: 40.0),
              const Text(
                "Welcome back you have been missed",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20.0),
              MyTextField(
                  controller: emailcontroller,
                  hintText: "Email",
                  obSecureText: false),
              const SizedBox(height: 10.0),
              MyTextField(
                  controller: passwordcontroller,
                  hintText: "Password",
                  obSecureText: true),
              const SizedBox(height: 20.0),
              myButton(text: "Sign In", onTap: SignIn),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member?"),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          )),
        ));
  }
}
