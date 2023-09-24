// ignore_for_file: prefer_const_constructors

import 'package:abid/frontend/client/laborProfile/labor_profile.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class booking_detail_labor extends StatefulWidget {
  String id;
  String name;
  String date;
  String address;
  String disc;
  String laborName;
  String laborImage;
  String laborUid;
  String status;
  String Bid;
  String Sid;
  String url;
  booking_detail_labor({
    super.key,
    required this.Bid,
    required this.Sid,
    required this.url,
    required this.address,
    required this.date,
    required this.disc,
    required this.id,
    required this.laborImage,
    required this.laborName,
    required this.laborUid,
    required this.name,
    required this.status,
  });

  @override
  State<booking_detail_labor> createState() => _booking_detail_laborState();
}

class _booking_detail_laborState extends State<booking_detail_labor> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.status == 'Complete'
          ? Container()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (widget.status != 'Canceled') {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(widget.Bid)
                          .update({
                        'status': 'Canceled',
                      });
                      Get.back();
                      Get.back();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel Booking',
                        style: GoogleFonts.chivo(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (widget.status != 'Canceled') {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(widget.Bid)
                          .update({
                        'status':
                            widget.status == 'Ongoing' ? 'Complete' : 'Ongoing',
                      });
                      if (widget.status == 'Pending') {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.laborUid)
                            .collection('chat')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'lastmessage': '',
                          'uid': FirebaseAuth.instance.currentUser!.uid,
                          'name': userData['username'],
                          'time': DateTime.now(),
                          'read': true,
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('chat')
                            .doc(widget.laborUid)
                            .set({
                          'lastmessage': '',
                          'uid': widget.laborUid,
                          'name': widget.laborName,
                          'time': DateTime.now(),
                          'read': true,
                        });
                      }
                      Get.back();
                      Get.back();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.status == 'Canceled'
                          ? Colors.grey
                          : widget.status == 'Ongoing'
                              ? Colors.green
                              : Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        widget.status == 'Ongoing'
                            ? 'Complete Work'
                            : 'Start Work',
                        style: GoogleFonts.chivo(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(widget.status,
            style: GoogleFonts.chivo(
              color: Colors.white,
              fontSize: 17,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking ID',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${widget.id}',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1.5,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8),
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 130,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            widget.name.toString().length <= 23
                                ? widget.name
                                : widget.name.toString().replaceRange(
                                    20, widget.name.toString().length, '..'),
                            style: GoogleFonts.chivo(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            'Date:',
                            style: GoogleFonts.chivo(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            widget.date,
                            style: GoogleFonts.chivo(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 7,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Address:',
                    //         style: GoogleFonts.chivo(
                    //           fontSize: 15,
                    //           color: Colors.grey,
                    //           fontWeight: FontWeight.w300,
                    //         ),
                    //       ),
                    //       Text(
                    //         widget.address,
                    //         style: GoogleFonts.chivo(
                    //           fontSize: 8,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w300,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                          image: NetworkImage(widget.url), fit: BoxFit.cover)),
                ),
              ),
            ],
          ),
          Container(
            height: 1.5,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8),
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Address:',
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(
              widget.address,
              textAlign: TextAlign.start,
              style: GoogleFonts.chivo(
                color: Color.fromARGB(255, 60, 60, 60),
                fontSize: 15,
              ),
            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                  'About Client:',
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
                    backgroundImage: NetworkImage(widget.laborImage),
                    radius: 30,
                  ),
                  Container(
                    height: 77,
                    width: MediaQuery.of(context).size.width - 130,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                widget.laborName,
                                style: GoogleFonts.chivo(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
