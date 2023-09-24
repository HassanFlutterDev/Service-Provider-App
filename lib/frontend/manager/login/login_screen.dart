// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types
import 'package:abid/frontend/manager/home/home_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../backend/auth/authFunctions.dart';
import '../../../widgets/snackbar.dart';

class manager_login_screen extends StatefulWidget {
  const manager_login_screen({super.key});

  @override
  State<manager_login_screen> createState() => _manager_login_screenState();
}

class _manager_login_screenState extends State<manager_login_screen> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  bool obsecure = true;
  bool isloading = false;

  // Future login() async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   AuthFunctions.instance.loginUser(emailc.text, passwordc.text);
  // }

  @override
  void dispose() {
    emailc.dispose();
    passwordc.dispose();

    super.dispose();
  }

  void _togglepassword() {
    if (obsecure == true) {
      setState(() {
        obsecure = false;
      });
    } else {
      setState(() {
        obsecure = true;
      });
    }
  }

  String error = '';
  String Perror = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Hello Again!',
                style: GoogleFonts.chivo(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Center(
              child: Text(
                'Welcome Back, You Have Been Missed For A Long Time.',
                textAlign: TextAlign.center,
                style: GoogleFonts.chivo(
                  fontSize: 17,
                  color: Color.fromARGB(255, 54, 54, 54),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            // height: 40,
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.07),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: emailc,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    suffixIcon: Icon(
                      EvaIcons.email_outline,
                    )),
              ),
            ),
          ),
          error.isEmpty
              ? Container()
              : Text(error,
                  style: TextStyle(
                    color: Colors.red,
                  )),
          SizedBox(height: 10),
          Container(
            // height: 40,
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.07),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: passwordc,
                obscureText: obsecure,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: _togglepassword,
                      child: Icon(
                        obsecure
                            ? EvaIcons.eye_off_2_outline
                            : EvaIcons.eye_outline,
                      ),
                    )),
              ),
            ),
          ),
          Perror.isEmpty
              ? Container()
              : Text(Perror,
                  style: TextStyle(
                    color: Colors.red,
                  )),
          SizedBox(
            height: 10,
          ),
          isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CupertinoButton(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.chivo(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    String result = await AuthFunction()
                        .loginUser(emailc.text, passwordc.text, context);

                    if (result == 'error-user') {
                      setState(() {
                        error = 'Email Not Found!';
                        Perror = '';
                        isloading = false;
                      });
                    } else if (result == 'error-pass') {
                      setState(() {
                        Perror = 'Wrong Password!';
                        error = '';
                        isloading = false;
                      });
                    } else if (result == 'fields-error') {
                      error = "Email is Empty";
                      Perror = "Password is Empty";
                      isloading = false;
                      setState(() {});
                    }
                    if (result == 'invalid-email') {
                      setState(() {
                        error = '';
                        Perror = '';
                        isloading = false;
                        error = "Your Email Is Badly Formatted!";
                      });
                    }
                    if (result == '') {
                      setState(() {
                        isloading = true;
                      });
                      var Usersnap = await FirebaseFirestore.instance
                          .collection('Admin')
                          .doc('Admin')
                          .get();
                      if (Usersnap.data()!['email'] == emailc.text) {
                        await Future.delayed(Duration(milliseconds: 3000))
                            .then((value) {
                          setState(() {
                            isloading = false;
                          });
                          Get.to(
                            home_manager(),
                            transition: Transition.downToUp,
                          );
                        });
                      } else {
                        setState(() {
                          isloading = false;
                        });
                        Showsnackbar(context,
                            'The Account You Enter is not a Manager Account');
                      }
                    }
                  }),
        ],
      ),
    );
  }
}
