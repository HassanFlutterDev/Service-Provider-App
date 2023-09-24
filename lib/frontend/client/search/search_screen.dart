// ignore_for_file: prefer_const_constructors

import 'package:abid/frontend/client/service/service_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  bool show = false;
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
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'All Services',
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
                      hintText: 'Search For Services',
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
              child: StreamBuilder(
                  stream: show
                      ? FirebaseFirestore.instance
                          .collection('services')
                          .where('searchIndex', arrayContains: search.text)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('services')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(snap['url']),
                                                  fit: BoxFit.cover),
                                              color: Colors.transparent),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                snap['name'],
                                                style: GoogleFonts.chivo(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snap['userImage']),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                snap['username'],
                                                style: GoogleFonts.chivo(
                                                  fontWeight: FontWeight.w300,
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
                                      padding: const EdgeInsets.only(top: 160),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  snap['price'],
                                                  style: GoogleFonts.chivo(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
