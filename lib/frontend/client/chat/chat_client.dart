// ignore_for_file: sort_child_properties_last

import 'package:abid/frontend/message/chat_Screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class chat_client extends StatefulWidget {
  const chat_client({super.key});

  @override
  State<chat_client> createState() => _chat_clientState();
}

class _chat_clientState extends State<chat_client> {
  String dateToday(DateTime Time) {
    final now = DateTime.now();
    String time = '';
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dateToCheck = Time;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return time = DateFormat.jm().format(Time);
    } else {
      return time = DateFormat.yMd().format(Time);
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Chat',
          style: GoogleFonts.chivo(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height - 168,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('chat')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snap = snapshot.data!.docs[index].data();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                  chat_screen(
                                      name: snap['name'], uid: snap['uid']),
                                  transition: Transition.downToUp);
                            },
                            child: Container(
                              height: 60,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 33,
                                    child: Center(
                                      child: Text(
                                        snap['name'].toString().replaceRange(1,
                                            snap['name'].toString().length, ''),
                                        style: GoogleFonts.chivo(
                                          color: kPrimaryColor,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.4),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 66,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, top: 4, right: 6),
                                          child: Row(
                                            children: [
                                              Text(
                                                snap['name'],
                                                style: GoogleFonts.chivo(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, top: 5, right: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snap['lastmessage']
                                                            .toString()
                                                            .length <=
                                                        23
                                                    ? snap['lastmessage']
                                                    : snap['lastmessage']
                                                        .toString()
                                                        .replaceRange(
                                                            20,
                                                            snap['lastmessage']
                                                                .toString()
                                                                .length,
                                                            '..'),
                                                style: GoogleFonts.chivo(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                dateToday(
                                                    snap['time'].toDate()),
                                                style: GoogleFonts.chivo(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!
                                              .withOpacity(0.1),
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
          )
        ],
      ),
    );
  }
}
