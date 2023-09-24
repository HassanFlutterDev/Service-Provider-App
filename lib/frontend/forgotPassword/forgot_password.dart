// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:abid/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController resetpassC = TextEditingController();

  Future resetPasswordF() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetpassC.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 120,
                child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    child: Icon(
                      Icons.check,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Reset Password Link sent to your Email.Please Check your Email.',
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 110,
                child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    e.message!,
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Entered Your Email and We will send Password Link',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.black,
                // ),

                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15,
                      offset: Offset(0, 2),
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Card(
              elevation: 0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Center(
                  child: TextField(
                    controller: resetpassC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.alternate_email_outlined,
                        color: kPrimaryColor,
                      ),
                      hintText: "Email",
                      fillColor: Colors.black,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          MaterialButton(
            onPressed: () async {
              await resetPasswordF();
              setState(() {
                resetpassC.clear();
              });
            },
            child: Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}
