// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:abid/frontend/client/booknow/booknow_Screen.dart';
import 'package:abid/frontend/client/laborProfile/labor_profile.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:abid/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class service_manager_detail extends StatefulWidget {
  String name;
  String catagory;
  String price;
  String dur;
  String rate;
  String uid;
  String id;
  String url;
  String disc;
  service_manager_detail(
      {super.key,
      required this.catagory,
      required this.dur,
      required this.name,
      required this.price,
      required this.rate,
      required this.disc,
      required this.id,
      required this.url,
      required this.uid});

  @override
  State<service_manager_detail> createState() => _service_manager_detailState();
}

class _service_manager_detailState extends State<service_manager_detail> {
  var userData = {};
  bool isLoading = false;
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
          .doc(widget.uid)
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CupertinoButton(
        onPressed: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Center(child: CircularProgressIndicator());
              });
          await FirebaseFirestore.instance
              .collection('Admin')
              .doc('Admin')
              .update({
            'services': FieldValue.arrayRemove([widget.id]),
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .update({
            'services': FieldValue.arrayRemove([widget.id]),
          });

          var getbook = await FirebaseFirestore.instance
              .collection('services')
              .doc(widget.id)
              .get();
          for (var i = 0; i < getbook.data()!['bookings'].length; i++) {
            await FirebaseFirestore.instance
                .collection('bookings')
                .doc(getbook.data()!['bookings'][i])
                .delete();
            await FirebaseFirestore.instance
                .collection('Admin')
                .doc('Admin')
                .update({
              'bookings':
                  FieldValue.arrayRemove([getbook.data()!['bookings'][i]]),
            });
          }
          await FirebaseFirestore.instance
              .collection('services')
              .doc(widget.id)
              .delete();
          Get.back();
          Showsnackbar(context, 'Service Successfully Deleted');
          Get.back();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor,
          ),
          child: Center(
            child: Text(
              'Delete Service',
              style: GoogleFonts.chivo(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.url),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken))),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(
                              EvaIcons.arrow_ios_back_outline,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    // color: ,/
                    child: Card(
                        color: Color.fromARGB(255, 255, 255, 255),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, left: 8),
                                  child: Text(
                                    widget.catagory,
                                    style: GoogleFonts.chivo(
                                      fontSize: 16,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    widget.name.toString().length <= 22
                                        ? widget.name.toString()
                                        : widget.name.toString().replaceRange(
                                            20,
                                            widget.name.toString().length,
                                            '..'),
                                    style: GoogleFonts.chivo(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${widget.price} PKR',
                                  style: GoogleFonts.chivo(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Duration',
                                    style: GoogleFonts.chivo(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${widget.dur} Hrs',
                                    style: GoogleFonts.chivo(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rating',
                                    style: GoogleFonts.chivo(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '★${widget.rate}',
                                    style: GoogleFonts.chivo(
                                      fontSize: 17,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Description:',
                          style: GoogleFonts.chivo(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Text(
                      widget.disc,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.chivo(
                        color: Color.fromARGB(255, 60, 60, 60),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'About Labor:',
                          style: GoogleFonts.chivo(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 77,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.06),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(isLoading
                                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU'
                                : userData['photoUrl']),
                            radius: 30,
                          ),
                          Container(
                            height: 77,
                            width: MediaQuery.of(context).size.width - 137,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        isLoading
                                            ? 'loading'
                                            : userData['username'],
                                        style: GoogleFonts.chivo(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 8),
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         '★★★★★',
                                //         style: TextStyle(
                                //           color: Colors.greenAccent,
                                //           fontSize: 17,
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
