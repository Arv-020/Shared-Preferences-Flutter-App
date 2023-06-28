import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/screens/signup_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _email = '';
  String _age = '';
  String _user = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _email = sp.getString('email')!;
    _age = sp.getString('age')!;
    _user = sp.getString('user')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.withOpacity(0.3),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin',
          style: TextStyle(color: Colors.tealAccent),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Text(
              "Email",
              style: TextStyle(color: Colors.tealAccent),
            ),
            trailing: Text(
              _email,
              style: const TextStyle(color: Colors.tealAccent),
            ),
          ),
          ListTile(
            leading: const Text(
              "Age",
              style: TextStyle(color: Colors.tealAccent),
            ),
            trailing: Text(
              _age,
              style: const TextStyle(color: Colors.tealAccent),
            ),
          ),
          ListTile(
            leading: const Text(
              "User Type",
              style: TextStyle(color: Colors.tealAccent),
            ),
            trailing: Text(
              _user,
              style: const TextStyle(color: Colors.tealAccent),
            ),
          ),
          Center(
              child: InkWell(
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.clear();
              Timer(const Duration(seconds: 1), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SignUpScreen())));
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0, 1)),
                  ]),
              child: const Center(
                child: Text(
                  "Log out",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
