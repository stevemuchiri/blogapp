import 'package:contentmanagement/login_page.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Content Hub',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height:400,
              width:300,
              child: Image.asset('assets/bbbb.png',),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to login page
                Navigator.pushReplacementNamed(context, '/login_page');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}