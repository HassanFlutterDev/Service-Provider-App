// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:abid/frontend/client/booknow/booknow_Screen.dart';
import 'package:abid/frontend/client/laborProfile/labor_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abid/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class service_client extends StatefulWidget {
  String name;
  String catagory;
  String price;
  String dur;
  String rate;
  String uid;
  String id;
  String url;
  String disc;
  service_client(
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
  State<service_client> createState() => _service_clientState();
}

class _service_clientState extends State<service_client> {
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
        onPressed: () {
          Get.to(
              BookNowScreen(
                id: widget.id,
                uid: widget.uid,
                name: widget.name,
                price: widget.price,
                catgory: widget.catagory,
                url: widget.url,
              ),
              transition: Transition.downToUp);
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
              'Book Now',
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
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('services')
                                .doc(widget.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              // log(widget.id);
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () async {
                                    if (snapshot.data?['like'].contains(
                                        FirebaseAuth
                                            .instance.currentUser!.uid)) {
                                      await FirebaseFirestore.instance
                                          .collection('services')
                                          .doc(widget.id)
                                          .update({
                                        'like': FieldValue.arrayRemove([
                                          FirebaseAuth.instance.currentUser!.uid
                                        ])
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'like':
                                            FieldValue.arrayRemove([widget.id])
                                      });
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('services')
                                          .doc(widget.id)
                                          .update({
                                        'like': FieldValue.arrayUnion([
                                          FirebaseAuth.instance.currentUser!.uid
                                        ])
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'like':
                                            FieldValue.arrayUnion([widget.id])
                                      });
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      snapshot.data?['like'].contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      size: 30,
                                      color: snapshot.data?['like'].contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              }
                              return CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  CupertinoIcons.heart,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              );
                            })
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
                          IconButton(
                            onPressed: () {
                              Get.to(
                                  LaborProfileScreen(
                                    uid: widget.uid,
                                  ),
                                  transition: Transition.downToUp);
                            },
                            icon: Icon(
                              EvaIcons.info_outline,
                              color: Colors.black,
                            ),
                          )
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
