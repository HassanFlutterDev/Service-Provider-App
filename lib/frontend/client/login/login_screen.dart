// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:abid/backend/auth/authFunctions.dart';
import 'package:abid/frontend/client/bottomNav/bottom_nav.dart';
import 'package:abid/frontend/client/signUp/signUp_screen.dart';
import 'package:abid/frontend/forgotPassword/forgot_password.dart';
import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class client_login_screen extends StatefulWidget {
  const client_login_screen({super.key});

  @override
  State<client_login_screen> createState() => _client_login_screenState();
}

class _client_login_screenState extends State<client_login_screen> {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(ForgotPassword(), transition: Transition.downToUp);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ))
              ],
            ),
            isloading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
                          isloading = false;
                          error = 'Email Not Found!';
                          Perror = '';
                        });
                      } else if (result == 'error-pass') {
                        setState(() {
                          isloading = false;
                          Perror = 'Wrong Password!';
                          error = '';
                        });
                      } else if (result == 'fields-error') {
                        error = "Email is Empty";
                        isloading = false;
                        Perror = "Password is Empty";
                        setState(() {});
                      }
                      if (result == 'invalid-email') {
                        setState(() {
                          isloading = false;
                          error = '';
                          Perror = '';
                          error = "Your Email Is Badly Formatted!";
                        });
                      }
                      if (result == '') {
                        setState(() {
                          isloading = true;
                        });
                        var Usersnap = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                        if (Usersnap.data()!['isLabor'] == false) {
                          await Future.delayed(Duration(milliseconds: 3000))
                              .then((value) {
                            setState(() {
                              isloading = false;
                            });
                            Get.to(
                              bottom_client(),
                              transition: Transition.downToUp,
                            );
                          });
                        } else {
                          setState(() {
                            isloading = false;
                          });
                          Showsnackbar(context,
                              'The Account You Enter is not a Client Account');
                        }
                      }
                    }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t Have an Account?',
                  style: GoogleFonts.chivo(
                    fontSize: 15,
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Get.to(signUp_client(), transition: Transition.downToUp);
                  },
                  child: Text(
                    'SignUp',
                    style: GoogleFonts.chivo(
                      fontSize: 15,
                      color: kPrimaryColor,
                      textBaseline: TextBaseline.ideographic,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
