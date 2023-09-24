// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:abid/backend/storage/firebase_stroaege.dart';
import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uuid/uuid.dart';

class ProfileEdit extends StatefulWidget {
  String url;
  bool isLabor;
  ProfileEdit({super.key, required this.url, required this.isLabor});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  PlatformFile? file;
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  var userData = {};
  bool load = false;
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
        name.text = userData['username'];
        phone.text = userData['number'];
      });
      if (widget.isLabor == true) {
        setState(() {
          about.text = userData['about'];
        });
      }
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Profile Edit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            load ? LinearProgressIndicator() : Container(),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                file == null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          widget.url,
                        ))
                    : CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: FileImage(File(file!.path!))),
                Positioned(
                  bottom: 5,
                  right: 0,
                  child: InkWell(
                      onTap: () async {
                        final results = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        setState(() {
                          file = results!.files.first;
                        });
                      },
                      child: Icon(EvaIcons.edit)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: 40,
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.07),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
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
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.07),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                  ),
                ),
              ),
            ),
            widget.isLabor
                ? SizedBox(
                    height: 10,
                  )
                : Container(),
            widget.isLabor
                ? Container(
                    // height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: about,
                        maxLines: 4,
                        minLines: 1,
                        maxLength: 300,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'About',
                        ),
                      ),
                    ),
                  )
                : Container(),
            CupertinoButton(
              onPressed: () async {
                setState(() {
                  load = true;
                });
                String id = Uuid().v1();
                String url = file == null
                    ? widget.url
                    : await storage().UploadFile(File(file!.path!), id);
                if (widget.isLabor == true) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'photoUrl': url,
                    'username': name.text,
                    'number': phone.text,
                    'about': about.text,
                  });
                } else {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'photoUrl': url,
                    'username': name.text,
                    'number': phone.text,
                  });
                }
                setState(() {
                  load = false;
                });
                Showsnackbar(context, 'Profile Successfully Edit!');
              },
              padding: EdgeInsets.all(10),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.chivo(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
