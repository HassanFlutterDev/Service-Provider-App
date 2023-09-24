// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:abid/frontend/client/booking/booking_detail.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class booking_client extends StatefulWidget {
  const booking_client({super.key});

  @override
  State<booking_client> createState() => _booking_clientState();
}

class _booking_clientState extends State<booking_client> {
  String? valuechanges;
  List catagi = [
    "Ongoing",
    "Pending",
    "Complete",
    "Canceled",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Booking',
          style: GoogleFonts.chivo(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              height: 70,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(EvaIcons.arrow_down),
                                isDense: true,
                                value: valuechanges,
                                hint: Text("All"),
                                items:
                                    catagi.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  setState(() {
                                    valuechanges = v;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 248,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bookings')
                    .where('uids',
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snap = snapshot.data!.docs[index].data();
                        return valuechanges != null
                            ? snap['status'] == valuechanges!
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          booking_detail_client(
                                              Bid: snap['bid'],
                                              Sid: snap['Sid'],
                                              url: snap['url'],
                                              address: snap['address'],
                                              date: snap['date'],
                                              disc: snap['disc'],
                                              id: snap['id'],
                                              laborImage: snap['laborImage'],
                                              laborName: snap['laborName'],
                                              laborUid: snap['laborUid'],
                                              name: snap['name'],
                                              status: snap['status']),
                                          transition: Transition.downToUp);
                                    },
                                    child: Container(
                                      height: 250,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!
                                              .withOpacity(0.1),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.26,
                                                color: Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          13),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      snap[
                                                                          'url']),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                color: Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 30,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: snap['status'] ==
                                                                      'Ongoing'
                                                                  ? Colors.blue
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : snap['status'] ==
                                                                          'Complete'
                                                                      ? Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.2)
                                                                      : Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                snap['status'],
                                                                style:
                                                                    GoogleFonts
                                                                        .chivo(
                                                                  color: snap['status'] ==
                                                                          'Ongoing'
                                                                      ? Colors
                                                                          .blue
                                                                      : snap['status'] ==
                                                                              'Complete'
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                            '#${snap['id']}',
                                                            style: GoogleFonts
                                                                .chivo(
                                                              color:
                                                                  kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
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
                                                            style: GoogleFonts
                                                                .chivo(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '${snap['price']} PKR',
                                                            style: GoogleFonts
                                                                .chivo(
                                                              fontSize: 17,
                                                              color:
                                                                  kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                          Container(
                                            height: 80,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 38,
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
                                                        child: Text(
                                                          'Date & Time',
                                                          style:
                                                              GoogleFonts.chivo(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          snap['date'],
                                                          style:
                                                              GoogleFonts.chivo(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!
                                                      .withOpacity(0.06),
                                                ),
                                                Container(
                                                  height: 38,
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
                                                        child: Text(
                                                          'Labor',
                                                          style:
                                                              GoogleFonts.chivo(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          snap['laborName'],
                                                          style:
                                                              GoogleFonts.chivo(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container()
                            : GestureDetector(
                                onTap: () {
                                  Get.to(
                                      booking_detail_client(
                                          Bid: snap['bid'],
                                          Sid: snap['Sid'],
                                          url: snap['url'],
                                          address: snap['address'],
                                          date: snap['date'],
                                          disc: snap['disc'],
                                          id: snap['id'],
                                          laborImage: snap['laborImage'],
                                          laborName: snap['laborName'],
                                          laborUid: snap['laborUid'],
                                          name: snap['name'],
                                          status: snap['status']),
                                      transition: Transition.downToUp);
                                },
                                child: Container(
                                  height: 250,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            height: 130,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            color: Colors.transparent,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  snap['url']),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 130,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            color: Colors.transparent,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: snap['status'] ==
                                                                  'Ongoing'
                                                              ? Colors.blue
                                                                  .withOpacity(
                                                                      0.2)
                                                              : snap['status'] ==
                                                                      'Complete'
                                                                  ? Colors.green
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : Colors.red
                                                                      .withOpacity(
                                                                          0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            snap['status'],
                                                            style: GoogleFonts
                                                                .chivo(
                                                              color: snap['status'] ==
                                                                      'Ongoing'
                                                                  ? Colors.blue
                                                                  : snap['status'] ==
                                                                          'Complete'
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Text(
                                                        '#${snap['id']}',
                                                        style:
                                                            GoogleFonts.chivo(
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
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
                                                        style:
                                                            GoogleFonts.chivo(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${snap['price']} PKR',
                                                        style:
                                                            GoogleFonts.chivo(
                                                          fontSize: 17,
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                      Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 38,
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                      'Date & Time',
                                                      style: GoogleFonts.chivo(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Text(
                                                      snap['date'],
                                                      style: GoogleFonts.chivo(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!
                                                  .withOpacity(0.06),
                                            ),
                                            Container(
                                              height: 38,
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                      'Labor',
                                                      style: GoogleFonts.chivo(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Text(
                                                      snap['laborName'],
                                                      style: GoogleFonts.chivo(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
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
          )
        ],
      ),
    );
  }
}
