import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/screens/admin_screen.dart';
import 'package:signup/screens/signup_screen.dart';
import 'package:signup/screens/student_screen.dart';
import 'package:signup/screens/teacher_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userState();
  }

  void userState() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool islogin = sp.getBool('islogin') ?? false;
    String usertype = sp.getString('user') ?? '';
    if (islogin) {
      if (usertype == 'Admin') {
        Timer(const Duration(seconds: 1), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminScreen()));
        });
      } else if (usertype == 'Teacher') {
        Timer(const Duration(seconds: 1), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TeacherScreen()));
        });
      } else {
        Timer(const Duration(seconds: 1), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StudentScreen()));
        });
      }
    } else {
      Timer(const Duration(seconds: 1), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.withOpacity(0.3),
        body: const Center(
          child: Center(
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.tealAccent),
            ),
          ),
        ));
  }
}
