// ignore_for_file: prefer_const_constructors

import 'package:abid/frontend/labor/service/service_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class request_Screen extends StatefulWidget {
  const request_Screen({super.key});

  @override
  State<request_Screen> createState() => _request_ScreenState();
}

class _request_ScreenState extends State<request_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Service-Requests',
            style: GoogleFonts.chivo(
              fontWeight: FontWeight.w400,
              fontSize: 21,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 104,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Admin')
                      .doc('Admin')
                      .collection('requests')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
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
                                  service_labor(
                                      catagory: snap['catagory'],
                                      desc: snap['disc'],
                                      dur: snap['duration'],
                                      star: '0',
                                      title: snap['name'],
                                      url: snap['url'],
                                      price: snap['price']),
                                  transition: Transition.downToUp,
                                );
                              },
                              child: Container(
                                height: 60,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          image: DecorationImage(
                                              image: NetworkImage(snap['url'])),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              166,
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 4, right: 6),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snap['catagory'],
                                                      style: GoogleFonts.chivo(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snap['disc']
                                                                  .toString()
                                                                  .length <
                                                              20
                                                          ? snap['disc']
                                                          : snap['disc']
                                                              .toString()
                                                              .replaceRange(
                                                                  20,
                                                                  snap['disc']
                                                                      .toString()
                                                                      .length,
                                                                  ''),
                                                      style: GoogleFonts.chivo(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                });
                                            String id = Uuid().v1();
                                            List<String> splitList =
                                                snap['name'].split(" ");
                                            // List<String> splitList1 = snap['name'].split("");
                                            List<String> searchIndex = [];
                                            searchIndex.add(
                                                snap['name'].toLowerCase());
                                            searchIndex.add(
                                                snap['name'].toUpperCase());
                                            searchIndex.add(snap['name']
                                                .replaceAll(" ", ''));
                                            searchIndex.add(snap['name']
                                                .split(" ")
                                                .removeLast());

                                            for (var i = 0;
                                                i < splitList.length;
                                                i++) {
                                              for (var y = 0;
                                                  y < splitList[i].length;
                                                  y++) {
                                                searchIndex.add(splitList[i]
                                                    .substring(0, y + 1)
                                                    .toLowerCase());
                                                searchIndex.add(splitList[i]
                                                    .substring(0, y + 1));
                                                searchIndex.add(splitList[i]
                                                    .substring(0, y + 1)
                                                    .toUpperCase());
                                              }
                                            }
                                            await FirebaseFirestore.instance
                                                .collection('Admin')
                                                .doc('Admin')
                                                .update({
                                              'services':
                                                  FieldValue.arrayUnion([id]),
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(snap['uid'])
                                                .update({
                                              'services':
                                                  FieldValue.arrayUnion([id]),
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('services')
                                                .doc(id)
                                                .set({
                                              'name': snap['name'],
                                              'disc': snap['disc'],
                                              'price': snap['price'],
                                              'duration': snap['duration'],
                                              'catagory': snap['catagory'],
                                              'uid': snap['uid'],
                                              'city': snap['City'],
                                              'searchIndex': searchIndex,
                                              'url': snap['url'],
                                              'username': snap['username'],
                                              'userImage': snap['userImage'],
                                              'star2': [],
                                              'star1': [],
                                              'star4': [],
                                              'star3': [],
                                              'star5': [],
                                              'id': id,
                                              'like': [],
                                              'bookings': [],
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('Admin')
                                                .doc('Admin')
                                                .collection('requests')
                                                .doc(snap['id'])
                                                .delete();
                                            Get.back();
                                          },
                                          child: CircleAvatar(
                                            radius: 17,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Admin')
                                                .doc('Admin')
                                                .collection('requests')
                                                .doc(snap['id'])
                                                .delete();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 17,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
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
      ),
    );
  }
}
