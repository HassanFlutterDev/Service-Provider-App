// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:abid/frontend/client/bottomNav/bottom_nav.dart';
import 'package:abid/frontend/labor/bottomNav/bottom_nav.dart';
import 'package:abid/frontend/manager/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getdoc();
  }

  Future getdoc() async {
    if (await FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com') {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
        return home_manager();
      }));
    } else {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (Usersnap.data()!['isLabor'] == true) {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
          return bottom_labor();
        }));
      } else {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
          return bottom_client();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
