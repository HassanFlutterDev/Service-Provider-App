// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class chat_screen extends StatefulWidget {
  String uid;
  String name;
  chat_screen({
    super.key,
    required this.name,
    required this.uid,
  });

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  TextEditingController text = TextEditingController();
  bool isloading = true;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 197, 255),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(children: [
            Expanded(
                child: CupertinoScrollbar(
              controller: _controller,
              child: GestureDetector(
                // onTap: () {
                //   // setState(() {
                //   //   show = false;
                //   //   focusNode.unfocus();
                //   // });
                // },
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('chat')
                        .doc(widget.uid)
                        .collection('messages')
                        .orderBy(
                          'time',
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.bounceInOut);
                      });
                      if (isloading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }
                      return ListView.builder(
                          controller: _controller,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs[index].data();
                            return snap['uid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? messageCard(
                                    message: snap['msg'],
                                    read: false,
                                    time: snap['time'])
                                : messageCard1(
                                    message: snap['msg'],
                                    read: false,
                                    time: snap['time']);
                          });
                    }),
              ),
            )),
            Container(
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      width: MediaQuery.of(context).size.width - 97,
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          controller: text,
                          maxLines: 2,
                          minLines: 1,
                          // autofocus: true,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a Message...',
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: InkWell(
                        onTap: () async {
                          String text1 = text.text;
                          setState(() {
                            text.clear();
                          });
                          if (text1.isNotEmpty) {
                            String id = Uuid().v1();

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('chat')
                                .doc(widget.uid)
                                .collection('messages')
                                .doc(id)
                                .set({
                              'msg': text1,
                              'time': DateTime.now(),
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'id': id,
                            });
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.uid)
                                .collection('chat')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('messages')
                                .doc(id)
                                .set({
                              'msg': text1,
                              'time': DateTime.now(),
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'id': id,
                            });
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.uid)
                                .collection('chat')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'time': DateTime.now(),
                              'read': true,
                              'lastmessage': text1,
                            });
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('chat')
                                .doc(widget.uid)
                                .update({
                              'time': DateTime.now(),
                              'read': true,
                              'lastmessage': text1,
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: kPrimaryColor,
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}

class messageCard extends StatelessWidget {
  String message;
  bool read;
  final time;
  messageCard(
      {Key? key, required this.message, required this.read, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor.withOpacity(1),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 11, vertical: 3),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 3, left: 15, right: 20, bottom: 5),
                      child:
                          Text(message, style: TextStyle(color: Colors.white)),
                    ),
                    // Positioned(
                    //   bottom: 4,
                    //   right: 10,\\\\
                    //   child:
                    // )
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat.jm().format(time.toDate()),
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMd().format(time.toDate()),
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class messageCard1 extends StatelessWidget {
  String message;
  bool read;
  final time;
  messageCard1(
      {Key? key, required this.message, required this.read, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor.withOpacity(0.6),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 11, vertical: 3),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 3, left: 15, right: 20, bottom: 5),
                      child:
                          Text(message, style: TextStyle(color: Colors.black)),
                    ),
                    // Positioned(
                    //   bottom: 4,
                    //   right: 10,\\\\
                    //   child:
                    // )
                  ]),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.jm().format(time.toDate()),
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMd().format(time.toDate()),
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
