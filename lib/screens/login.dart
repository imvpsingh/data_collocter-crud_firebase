import 'package:data_collocter/screens/forgotPassword.dart';
import 'package:data_collocter/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/custom_text.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  String massage = "";
  Color massageColor = const Color(0xff632720);
  Color fieldBorderColor = Colors.black54;

  // bool isLoading = false;

  login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) => {
              Fluttertoast.showToast(msg: 'Login Successfully'),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(uid: value.user!.uid))),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Welcome Back',
                fontSize: 28,
                shadow: [],
                color: Colors.red,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomText(
                text: massage,
                fontSize: 20,
                shadow: const [],
                color: massageColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: fieldBorderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Email",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                  valueListenable: isVisible,
                  builder: (context, val, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: fieldBorderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        obscureText: isVisible.value,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          suffixIcon: InkWell(
                              onTap: () {
                                isVisible.value = !isVisible.value;
                              },
                              child: isVisible.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    );
                  }),
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
                    if (emailController.text != "" &&
                        passwordController.text != "") {
                      setState(() {
                        massage = "";
                        isLoading.value = !isLoading.value;
                        fieldBorderColor = Colors.black54;
                      });
                      login();
                    } else {
                      setState(() {
                        massageColor = const Color(0xffe48077);
                        massage = "fill all field";
                        fieldBorderColor = Colors.red;
                      });
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, value, index) {
                        return CustomText(
                          isLoading: isLoading.value,
                          text: "Go",
                          fontSize: 18,
                          shadow: const [],
                          color: Colors.white,
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text('New User ? Register')),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                  },
                  child: const Text('Forgot Email'))
            ],
          ),
        ),
      ),
    );
  }
}
