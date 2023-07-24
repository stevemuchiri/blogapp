import 'profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';
import 'login_page.dart';
import 'HomePage.dart';
import 'package:contentmanagement/signup_page.dart';

//void main() => runApp(LoginSignupApp());

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(contentApp());
}

class contentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Content management',
        theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

    initialRoute: 'WelcomeScreen',
    routes: {
      '/': (context) => WelcomeScreen(),
      '/login_page': (context) => login_page(),
      '/signup_page': (context) => signup_page(),
      '/HomePage': (context) => HomePage(),
      '/profile': (context) => profile(),
    }
    );
  }
}