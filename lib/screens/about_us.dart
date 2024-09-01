import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'About Us', fontSize: 22),
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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Developer Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Name: VP SINGH RAJPUT',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Education: Pursuing BCA from Jaipur',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Role: Fresher',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Development Year: 2024',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'API: Pexels',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Additional Information: This is my first Flutter application. I am a BCA student from Jaipur and I am excited to learn and grow in the field of app development.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL('https://en.wikipedia.org/wiki/V._P._Singh'),
                        child: Image.asset(
                          "assets/man.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL('https://instagram.com/im.vpsingh'),
                        child: Image.asset(
                          "assets/instagram.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL('https://linkedin.com/in/im.vpsingh'),
                        child: Image.asset(
                          "assets/linkedin.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL('https://twitter.com/vpsinghrajput'),
                        child: Image.asset(
                          "assets/twitter.png",
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
