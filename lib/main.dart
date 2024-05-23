import 'package:data_collocter/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        measurementId: "G-5C1CGSSMML"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Collector',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const HomeScreen(),
    );
  }
}
