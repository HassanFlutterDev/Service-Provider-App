// ignore_for_file: prefer_const_constructors

import 'package:abid/frontend/client/profile/profile_edit.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../selection/selection_screen.dart';

class profile_labor extends StatefulWidget {
  const profile_labor({super.key});

  @override
  State<profile_labor> createState() => _profile_laborState();
}

class _profile_laborState extends State<profile_labor> {
  bool isLoading = false;
  var userData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.chivo(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 43,
                        backgroundImage: NetworkImage(isLoading
                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU'
                            : userData['photoUrl']),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            ProfileEdit(
                                url: userData['photoUrl'], isLabor: true),
                            transition: Transition.downToUp,
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            EvaIcons.edit_2_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLoading ? 'Loading..' : userData['username'],
                  style: GoogleFonts.chivo(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLoading ? 'Loading..' : userData['email'],
                  style: GoogleFonts.chivo(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: kPrimaryColor.withOpacity(0.1),
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'General',
                    style: GoogleFonts.chivo(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.clipboard_outline,
                color: Colors.black,
              ),
              title: Text(
                'Blog',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.star_outline,
                color: Colors.black,
              ),
              title: Text(
                'Rate Us',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: kPrimaryColor.withOpacity(0.1),
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'About App',
                    style: GoogleFonts.chivo(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.info_outline,
                color: Colors.black,
              ),
              title: Text(
                'About App',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.shield_outline,
                color: Colors.black,
              ),
              title: Text(
                'Privacy Policy',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.question_mark_circle_outline,
                color: Colors.black,
              ),
              title: Text(
                'Support & Help',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.phone_call_outline,
                color: Colors.black,
              ),
              title: Text(
                'Helpline Number',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: Colors.red.withOpacity(0.1),
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Danger Zone',
                    style: GoogleFonts.chivo(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.person_remove_outline,
                color: Colors.black,
              ),
              title: Text(
                'Delete Account',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Get.to(selection_screen());
                });
              },
              leading: Icon(
                EvaIcons.log_out_outline,
                color: Colors.black,
              ),
              title: Text(
                'LogOut',
                style: GoogleFonts.chivo(
                  color: Colors.black,
                  // fontSize: 17,
                ),
              ),
              trailing: Icon(
                EvaIcons.arrow_ios_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
