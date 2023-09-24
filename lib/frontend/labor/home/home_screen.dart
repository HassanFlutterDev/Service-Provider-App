// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty

import 'package:abid/frontend/labor/add%20Service/add_service.dart';
import 'package:abid/frontend/labor/service/service_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class home_labor extends StatefulWidget {
  const home_labor({super.key});

  @override
  State<home_labor> createState() => _home_laborState();
}

class _home_laborState extends State<home_labor> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
              add_service_labor(
                name: userData['username'],
                url: userData['photoUrl'],
              ),
              transition: Transition.downToUp);
        },
        child: Icon(
          EvaIcons.plus,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Labor Home',
            style: GoogleFonts.chivo(
              fontWeight: FontWeight.w400,
              fontSize: 21,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello, ${isLoading ? 'Loading...' : userData['username']}',
                    style: GoogleFonts.chivo(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Welcome Back!',
                    style: GoogleFonts.chivo(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isLoading
                                    ? '0'
                                    : userData['bookings'].length.toString(),
                                style: GoogleFonts.chivo(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.book_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Total Bookings',
                                style: GoogleFonts.chivo(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isLoading
                                    ? '0'
                                    : userData['services'].length.toString(),
                                style: GoogleFonts.chivo(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.handyman,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Your Services',
                                style: GoogleFonts.chivo(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Services',
                    style: GoogleFonts.chivo(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('services')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var snap = snapshot.data!.docs[index].data();
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  service_labor(
                                    url: snap['url'],
                                    title: snap['name'],
                                    catagory: snap['catagory'],
                                    desc: snap['disc'],
                                    price: snap['price'],
                                    dur: snap['duration'],
                                    star:
                                        '${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}',
                                  ),
                                  transition: Transition.downToUp);
                            },
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(snap['url']),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width -
                                          145,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snap['name']
                                                              .toString()
                                                              .length <=
                                                          23
                                                      ? snap['name']
                                                      : snap['name']
                                                          .toString()
                                                          .replaceRange(
                                                              20,
                                                              snap['name']
                                                                  .toString()
                                                                  .length,
                                                              '..'),
                                                  style: GoogleFonts.chivo(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '★${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}',
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 13,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${snap['bookings'].length} Bookings',
                                                  style: GoogleFonts.chivo(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snap['disc'].toString().length <=
                                                      100
                                                  ? snap['disc']
                                                  : snap['disc']
                                                      .toString()
                                                      .replaceRange(
                                                          100,
                                                          snap['disc']
                                                              .toString()
                                                              .length,
                                                          '..'),
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.chivo(
                                                color: Color.fromARGB(
                                                    255, 60, 60, 60),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
