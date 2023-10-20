import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:signup/screens/home_screen.dart';
import 'package:signup/screens/student_screen.dart';
import 'package:signup/screens/teacher_screen.dart';
import 'dart:developer' as console show log;

import 'admin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? valueChoose;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _age = TextEditingController();
  bool visible = false;
  List listItem = ['Admin', 'Student', 'Teacher'];

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _email.dispose();
    _password.dispose();
    _age.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.withOpacity(0.3),
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.indigo.withOpacity(0.5),
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.tealAccent),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.3),
                border: Border.all(color: Colors.tealAccent, width: 1),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DropdownButton(
                underline: const SizedBox(),
                elevation: 0,
                isExpanded: true,
                dropdownColor: Colors.teal,
                hint: const Center(
                  child: Text(
                    "select user type",
                    style: TextStyle(color: Colors.tealAccent),
                  ),
                ),
                value: valueChoose,
                onChanged: (newValue) async {
                  setState(() {
                    valueChoose = newValue.toString();
                  });
                },
                items: listItem.map((newItem) {
                  return DropdownMenuItem(
                    value: newItem,
                    child: Center(
                      child: Text(
                        newItem,
                        style: const TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  );
                }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.tealAccent,
              style: const TextStyle(color: Colors.tealAccent),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.teal),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
                fillColor: Colors.teal.withOpacity(0.4),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.tealAccent),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextFormField(
              controller: _password,
              enableSuggestions: false,
              obscureText: !visible ? true : false,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Colors.tealAccent,
              style: const TextStyle(color: Colors.tealAccent),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.teal),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.teal,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    visible = !visible;
                    console.log(visible.toString());
                    setState(() {});
                  },
                  child: Icon(
                    visible == true ? Icons.visibility : Icons.visibility_off,
                    color: Colors.teal,
                  ),
                ),
                fillColor: Colors.teal.withOpacity(0.4),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.tealAccent),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              cursorColor: Colors.tealAccent,
              style: const TextStyle(color: Colors.tealAccent),
              decoration: InputDecoration(
                hintText: 'Age',
                hintStyle: const TextStyle(color: Colors.teal),
                prefixIcon: const Icon(
                  Icons.numbers,
                  color: Colors.teal,
                ),
                fillColor: Colors.teal.withOpacity(0.4),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.tealAccent),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (_email.text.trim().isEmpty &&
                  _age.text.trim().isEmpty &&
                  _password.text.trim().isEmpty) {
                customDialog("Empty Field", "Fill all Fields..");
              } else {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', _email.text);
                sp.setString('age', _age.text.toString());

                sp.setBool('islogin', true);
                sp.setString('user', valueChoose.toString());
                String usertype = valueChoose.toString();

                if (usertype == 'Admin') {
                  Timer(const Duration(seconds: 1), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()));
                  });
                } else if (usertype == 'Teacher') {
                  Timer(const Duration(seconds: 1), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TeacherScreen()));
                  });
                } else if (usertype == 'Student') {
                  Timer(const Duration(seconds: 1), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentScreen()));
                  });
                } else {
                  customDialog(
                      "Select User", "Select Among Admin,Teacher,Student");
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
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
                  "Sign Up",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void customDialog(String title, String content) {
    showDialog(
      // barrierColor: Colors.teal, to add the blue or something in the background
      context: context,
      builder: (context) {
        return AlertDialog(
          // alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.teal,
          title: Text(title),
          titleTextStyle:
              const TextStyle(color: Colors.tealAccent, fontSize: 16),
          content: Text(content),
          contentTextStyle:
              const TextStyle(color: Colors.tealAccent, fontSize: 14),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.tealAccent),
                ))
          ],
        );
      },
    );
  }
}
