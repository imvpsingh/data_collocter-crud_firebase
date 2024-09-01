import 'package:data_collocter/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  Color fieldBorderColor = Colors.black54;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Forgot Password',
                fontSize: 28,
                shadow: [],
                color: Colors.red,
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: fieldBorderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@gmail.com')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        emailController.clear();
                        Fluttertoast.showToast(
                          msg: 'Password reset link sent! Check your email.',
                          toastLength: Toast.LENGTH_LONG,
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: e.toString(),
                          toastLength: Toast.LENGTH_LONG,
                        );
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      setState(() {
                        fieldBorderColor = Colors.red;
                      });
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const CustomText(
                    text: "Send Forgot Password Link",
                    fontSize: 18,
                    shadow: [],
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text('Go to Login Screen'))
            ],
          ),
        ),
      ),
    );
  }
}
