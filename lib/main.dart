import 'package:data_collocter/screens/home_screen.dart';
import 'package:data_collocter/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAnmvBXLrHqI3SoLWBpBwmP7NT_r62gqiA',
      authDomain: 'data-collector-e39d3.firebaseapp.com',
      projectId: 'data-collector-e39d3',
      storageBucket: 'data-collector-e39d3.appspot.com',
      messagingSenderId: '75169023102',
      appId: '1:75169023102:web:bebe00680977272a04c42f',
      measurementId: "G-5C1CGSSMML",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  String? uid;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    uid = await getUid();
    setState(() {});
  }

  Future<String?> getUid() async {
    return _prefs.getString('uid');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Collector',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return HomeScreen(uid: uid ?? '');
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
