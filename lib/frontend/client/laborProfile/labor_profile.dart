// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_is_empty

import 'package:abid/frontend/client/service/service_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class LaborProfileScreen extends StatefulWidget {
  String uid;
  LaborProfileScreen({super.key, required this.uid});

  @override
  State<LaborProfileScreen> createState() => _LaborProfileScreenState();
}

class _LaborProfileScreenState extends State<LaborProfileScreen> {
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

  rating(List star1, List star2, List star3, List star4, List star5) {
    if (star2.length > star1.length &&
        star2.length > star3.length &&
        star2.length > star4.length &&
        star2.length > star5.length) {
      return 2.0;
    } else if (star1.length > star2.length &&
        star1.length > star3.length &&
        star1.length > star4.length &&
        star1.length > star5.length) {
      return 1.0;
    } else if (star3.length > star2.length &&
        star3.length > star1.length &&
        star3.length > star4.length &&
        star3.length > star5.length) {
      return 3.0;
    } else if (star4.length > star3.length &&
        star4.length > star1.length &&
        star4.length > star2.length &&
        star4.length > star5.length) {
      return 4.0;
    }
    if (star5.length > star3.length &&
        star5.length > star2.length &&
        star5.length > star4.length &&
        star5.length > star1.length) {
      return 5.0;
    } else {
      return 0.0;
    }
    // ignore: dead_code
    if (star1.length != 0 && star2.length != 0) {
      if (star1.length == star2.length) {
        return 1.0;
      }
    } else if (star2.length != 0 && star3.length != 0) {
      if (star2.length == star3.length) {
        return 2.0;
      }
    } else if (star3.length != 0 && star1.length != 0) {
      if (star3.length == star1.length) {
        return 3.0;
      }
    } else if (star4.length != 0 && star2.length != 0) {
      if (star4.length == star2.length) {
        return 4.0;
      } else if (star4.length != 0 && star3.length != 0) {
        if (star4.length == star3.length) {
          return 4.0;
        }
      } else if (star4.length != 0 && star1.length != 0) {
        if (star4.length == star1.length) {
          return 4.0;
        }
      } else if (star5.length != 0 && star2.length != 0) {
        if (star5.length == star2.length) {
          return 5.0;
        }
      } else if (star5.length != 0 && star4.length != 0) {
        if (star5.length == star4.length) {
          return 4.0;
        }
      } else if (star5.length != 0 && star3.length != 0) {
        if (star5.length == star3.length) {
          return 4.0;
        }
      } else if (star5.length != 0 && star1.length != 0) {
        if (star5.length == star1.length) {
          return 5.0;
        }
      }
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            EvaIcons.arrow_ios_back,
                            color: Colors.white,
                          )),
                      Text(
                        'About Labor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 92,
                ),
                Container(
                  height: 130,
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  // color: ,/
                  child: Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(isLoading
                                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU'
                                      : userData['photoUrl']),
                                  backgroundColor: kPrimaryColor,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 134,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              isLoading
                                                  ? 'Loading...'
                                                  : userData['username'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Member Joined Since ${isLoading ? 'Loading...' : DateFormat.y().format(userData['date'].toDate())}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Text(
                    isLoading ? 'Loading...' : userData['about'],
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
                        'Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 344,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('services')
                          .where('uid', isEqualTo: widget.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var snap = snapshot.data!.docs[index].data();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        service_client(
                                          name: snap['name'],
                                          dur: snap['duration'],
                                          rate:
                                              '${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}',
                                          url: snap['url'],
                                          disc: snap['disc'],
                                          catagory: snap['catagory'],
                                          uid: snap['uid'],
                                          price: snap['price'],
                                          id: snap['id'],
                                        ),
                                        transition: Transition.downToUp);
                                  },
                                  child: Container(
                                    height: 300,
                                    width: 280,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 180,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snap['url']),
                                                      fit: BoxFit.cover),
                                                  color: Colors.transparent),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}★',
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 17,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    snap['name'],
                                                    style: GoogleFonts.chivo(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            snap['userImage']),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    snap['username'],
                                                    style: GoogleFonts.chivo(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                snap['catagory']
                                                            .toString()
                                                            .length <=
                                                        10
                                                    ? snap['catagory']
                                                    : snap['catagory']
                                                        .toString()
                                                        .replaceRange(
                                                            9,
                                                            snap['catagory']
                                                                .toString()
                                                                .length,
                                                            '..'),
                                                style: GoogleFonts.chivo(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 160),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snap['price'],
                                                      style: GoogleFonts.chivo(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
