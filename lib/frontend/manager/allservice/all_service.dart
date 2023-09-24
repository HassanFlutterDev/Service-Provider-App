// ignore_for_file: prefer_const_constructors

import 'package:abid/frontend/manager/service%20Detail/service_Details.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllServiceManager extends StatefulWidget {
  const AllServiceManager({super.key});

  @override
  State<AllServiceManager> createState() => _AllServiceManagerState();
}

class _AllServiceManagerState extends State<AllServiceManager> {
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'All-Service',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 88,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('services')
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
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snap = snapshot.data!.docs[index].data();
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                service_manager_detail(
                                  name: snap['name'],
                                  dur: snap['duration'],
                                  rate:
                                      '${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}',
                                  id: snap['id'],
                                  url: snap['url'],
                                  disc: snap['disc'],
                                  catagory: snap['catagory'],
                                  uid: snap['uid'],
                                  price: snap['price'],
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
                                    width:
                                        MediaQuery.of(context).size.width - 145,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
        ],
      ),
    );
  }
}
