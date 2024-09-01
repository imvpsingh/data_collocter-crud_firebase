import 'package:data_collocter/screens/home_screen.dart';
import 'package:data_collocter/screens/login.dart';
import 'package:data_collocter/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ValueNotifier<bool> isHide = ValueNotifier<bool>(true);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  String massage = "";
  Color massageColor = const Color(0xff632720);
  Color fieldBorderColor = Colors.black54;
  late SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

  }
  signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: confirmPasswordController.text).then((value)=>{
          print(value),
          Fluttertoast.showToast(msg: 'Register Successfully'),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(uid: value.user!.uid))),
     _prefs.setString('uid', value.user!.uid)
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  text: 'Welcome To DaTa FluX',
                  fontSize: 25,
                  shadow: [],
                  color: Colors.red,
                ),
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
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                  valueListenable: isHide,
                  builder: (context, val, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: fieldBorderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        obscureText: isHide.value,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                  valueListenable: isHide,
                  builder: (context, value, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: fieldBorderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        obscureText: isHide.value,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Confirm Password",
                          suffixIcon: InkWell(
                              onTap: () {
                                isHide.value = !isHide.value;
                              },
                              child: isHide.value
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
                width: 150,
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: TextButton(
                  onPressed: () async {
                    if (emailController.text != "" &&
                        passwordController.text != "" &&
                        confirmPasswordController.text != "") {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        setState(() {
                          massage = "";
                          isLoading.value = !isLoading.value;
                          fieldBorderColor = Colors.black54;
                        });
                        signup();
                      } else {
                        setState(() {
                          massage = "Password Not Match";
                        });
                      }
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
                          text: "Register",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text('already have an account ? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
