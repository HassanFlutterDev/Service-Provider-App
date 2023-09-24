// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class AllUsersManager extends StatefulWidget {
  const AllUsersManager({super.key});

  @override
  State<AllUsersManager> createState() => _AllUsersManagerState();
}

class _AllUsersManagerState extends State<AllUsersManager> {
  TextEditingController search = TextEditingController();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'All-Users',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 40,
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.09),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        setState(() {
                          show = true;
                        });
                      } else {
                        setState(() {
                          show = false;
                        });
                      }
                    },
                    controller: search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        EvaIcons.search_outline,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Search Users',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 170,
              width: double.infinity,
              child: StreamBuilder(
                  stream: show
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .where('isLabor', isEqualTo: false)
                          .where('searchIndex', arrayContains: search.text)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where('isLabor', isEqualTo: false)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return AutoHeightGridView(
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        shrinkWrap: true,
                        builder: (context, index) {
                          var snap = snapshot.data!.docs[index].data();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(3, 3),
                                    spreadRadius: 1,
                                    blurRadius: 9,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(snap['photoUrl']),
                                            fit: BoxFit.fill)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          snap['username'],
                                          style: GoogleFonts.chivo(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                              text: snap['number']))
                                          .then((result) {
                                        // show toast or snackbar after successfully save
                                        Showsnackbar(context,
                                            'Phone Number Successfully Copied!');
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor:
                                              kPrimaryColor.withOpacity(0.7),
                                          child: Icon(
                                            EvaIcons.phone_call_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                    text: snap['email']))
                                                .then((result) {
                                              // show toast or snackbar after successfully save
                                              Showsnackbar(context,
                                                  'Email Successfully Copied!');
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                kPrimaryColor.withOpacity(0.7),
                                            child: Icon(
                                              EvaIcons.email_outline,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                });
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('Admin')
                                                  .doc('Admin')
                                                  .update({
                                                'users': FieldValue.arrayRemove(
                                                    [snap['uid']]),
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(snap['uid'])
                                                  .delete();
                                              UserCredential userCredential =
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email: snap['email'],
                                                          password:
                                                              snap['password']);

                                              log(FirebaseAuth
                                                  .instance.currentUser!.uid);
                                              userCredential.user!.delete();
                                              UserCredential userCred =
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email:
                                                              'admin@gmail.com',
                                                          password:
                                                              'OLHAdmin123@');
                                              log(FirebaseAuth
                                                  .instance.currentUser!.uid);
                                              Get.back();
                                              Showsnackbar(context,
                                                  'Labor Successfully Deleted');
                                              // .deleteuser(); // called from database class
                                              // await result.user!.delete();
                                            } catch (e) {
                                              log(e.toString());
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                Colors.red.withOpacity(0.7),
                                            child: Icon(
                                              EvaIcons.person_remove_outline,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
