import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Privacy Policy', fontSize: 22),
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black87,

        ),
      ),
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.blue[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Our Privacy Policy explains our principles when it comes to the collection, processing, and storage of your information. This policy specifically explains how we, our partners, and users of our services deploy cookies, as well as the options you have to control them.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Information We Collect',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'We collect information about you when you provide it to us, when you use our services, and when other sources provide it to us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How We Use Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'We use the information we collect to provide, maintain, and improve our services, as well as to develop new services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
