// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:abid/frontend/client/bottomNav/bottom_nav.dart';
import 'package:abid/frontend/labor/bottomNav/bottom_nav.dart';
import 'package:abid/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../backend/auth/authFunctions.dart';

class signUp_labor extends StatefulWidget {
  const signUp_labor({super.key});

  @override
  State<signUp_labor> createState() => _signUp_laborState();
}

class _signUp_laborState extends State<signUp_labor> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool obsecure = true;
  bool isloading = false;
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

  String Ferror = '';
  String Lerror = '';
  String Nerror = '';
  String error = '';
  String Eerror = '';
  String Perror = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: kPrimaryColor,
                child: Icon(
                  EvaIcons.person_outline,
                  color: Colors.white,
                  size: 55,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Hello Labor!',
                  style: GoogleFonts.chivo(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'SignUp For Better Experience',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chivo(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                  controller: firstName,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'First Name',
                      suffixIcon: Icon(
                        EvaIcons.person_outline,
                      )),
                ),
              ),
            ),
            Ferror.isEmpty
                ? Container()
                : Text(Ferror,
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
                  controller: lastName,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Last Name',
                      suffixIcon: Icon(
                        EvaIcons.person_outline,
                      )),
                ),
              ),
            ),
            Lerror.isEmpty
                ? Container()
                : Text(Lerror,
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
                  controller: username,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                      suffixIcon: Icon(
                        EvaIcons.person_outline,
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
            Eerror.isEmpty
                ? Container()
                : Text(Eerror,
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
                  controller: phoneNumber,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Contact Number',
                      suffixIcon: Icon(
                        EvaIcons.phone_call_outline,
                      )),
                ),
              ),
            ),
            Nerror.isEmpty
                ? Container()
                : Text(Nerror,
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
            SizedBox(height: 10),
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
                          'SignUp',
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
                      if (username.text.length <= 5) {
                        setState(() {
                          isloading = false;
                          error = 'Username Should be at least 6 Characters!';
                        });
                      } else if (firstName.text.isEmpty) {
                        setState(() {
                          isloading = false;
                          Ferror = 'First Name cannot be Empty';
                        });
                      } else if (lastName.text.isEmpty) {
                        setState(() {
                          isloading = false;
                          Lerror = 'Lasst Name cannot be Empty';
                        });
                      } else if (phoneNumber.text.isEmpty) {
                        setState(() {
                          isloading = false;
                          Nerror = 'Phone Number cannot be Empty';
                        });
                      } else {
                        String result = await AuthFunction().Signup(
                            emailc.text,
                            passwordc.text,
                            username.text,
                            lastName.text,
                            firstName.text,
                            phoneNumber.text,
                            true,
                            // _image!
                            context);
                        // String result = '';
                        print(result);
                        if (result == 'password-error') {
                          setState(() {
                            isloading = false;
                            error = '';

                            Eerror = '';
                            Perror =
                                "Password Should be at least 6 Characters!";
                          });
                        }
                        if (result == 'email-error') {
                          setState(() {
                            isloading = false;
                            error = '';
                            Perror = '';
                            Eerror =
                                "Email is Already in Used By Another Account!";
                          });
                        }
                        if (result == 'fields-error') {
                          setState(() {
                            isloading = false;
                            // error = "Username is Empty";
                            Eerror = "Email is Empty";
                            Perror = "Password is Empty";
                          });
                        }
                        if (result == 'invalid-email') {
                          setState(() {
                            isloading = false;
                            error = '';
                            Perror = '';
                            Eerror = "Your Email Is Badly Formatted!";
                          });
                        }
                        if (username.text.length <= 5) {
                          setState(() {
                            isloading = false;
                            error = 'Username Should be 6 Characters!';
                          });
                        }
                        if (result == '' && username.text.length >= 5) {
                          setState(() {
                            isloading = true;
                          });
                          Get.to(bottom_labor(),
                              transition: Transition.downToUp);
                        }
                      }
                    }),
          ],
        ),
      ),
    );
  }
}
