import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

import '../Components/MyTextField.dart';
import '../Components/myButton.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final confirmPassword = TextEditingController();
  final passwordcontroller = TextEditingController();
  Future<void> SignUp() async {
    if (passwordcontroller.text != confirmPassword.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password do not match")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.message,
                size: 100,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Lets create an account for you",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20.0),
              MyTextField(
                  controller: emailcontroller,
                  hintText: "Email",
                  obSecureText: false),
              const SizedBox(height: 15.0),
              MyTextField(
                  controller: passwordcontroller,
                  hintText: "Password",
                  obSecureText: true),
              const SizedBox(height: 15.0),
              MyTextField(
                  controller: confirmPassword,
                  hintText: "Password",
                  obSecureText: true),
              const SizedBox(height: 15.0),
              myButton(text: "Sign Up", onTap: SignUp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member?"),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Log in now',
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
