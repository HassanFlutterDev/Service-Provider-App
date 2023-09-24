// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:abid/frontend/client/booking/booking_client.dart';
import 'package:abid/frontend/client/catagory/catagory_client.dart';
import 'package:abid/frontend/client/home/home_screen.dart';
import 'package:abid/frontend/client/profile/profile_client.dart';
import 'package:abid/theme/theme.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../chat/chat_client.dart';

class bottom_client extends StatefulWidget {
  const bottom_client({super.key});

  @override
  State<bottom_client> createState() => _bottom_clientState();
}

class _bottom_clientState extends State<bottom_client> {
  List imageList = [
    {"id": 1, "image_path": 'images/sofa.jpg'},
    {"id": 2, "image_path": 'images/sofa1.jpg'},
    {"id": 3, "image_path": 'images/sofa3.jpg'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  int currentPage = 0;
  List<Widget> pages = [
    home_client(),
    booking_client(),
    catagory_client(),
    chat_client(),
    profile_client()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Container(
          height: 80,
          color: Colors.transparent,
          //we use Stack(); because we want the effects be on top of each other,
          //  just like layer in photoshop.
          child: Stack(
            children: [
              //blur effect ==> the third layer of stack
              BackdropFilter(
                filter: ImageFilter.blur(
                  //sigmaX is the Horizontal blur
                  sigmaX: 6.0,
                  //sigmaY is the Vertical blur
                  sigmaY: 6.0,
                ),
                //we use this container to scale up the blur effect to fit its
                //  parent, without this container the blur effect doesn't appear.
                child: Container(),
              ),
              //gradient effect ==> the second layer of stack
              Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.18)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //begin color
                        Colors.white.withOpacity(0.18),
                        //end color
                        Colors.white.withOpacity(0.05),
                      ]),
                ),
              ),
              //child ==> the first/top layer of stack
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 30,
                                  width: currentPage == 0
                                      ? MediaQuery.of(context).size.width * 0.18
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      EvaIcons.home_outline,
                                      color: currentPage == 0
                                          ? kPrimaryColor
                                          : Color.fromARGB(255, 129, 129, 129),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Home',
                              style: GoogleFonts.chivo(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: currentPage == 0
                                    ? kPrimaryColor
                                    : Color.fromARGB(255, 129, 129, 129),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = 1;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 30,
                                  width: currentPage == 1
                                      ? MediaQuery.of(context).size.width * 0.18
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      FontAwesome.ticket,
                                      color: currentPage == 1
                                          ? kPrimaryColor
                                          : Color.fromARGB(255, 129, 129, 129),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Bookings',
                              style: GoogleFonts.chivo(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: currentPage == 1
                                    ? kPrimaryColor
                                    : Color.fromARGB(255, 129, 129, 129),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = 2;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 30,
                                  width: currentPage == 2
                                      ? MediaQuery.of(context).size.width * 0.18
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      EvaIcons.grid_outline,
                                      color: currentPage == 2
                                          ? kPrimaryColor
                                          : Color.fromARGB(255, 129, 129, 129),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Catagories',
                              style: GoogleFonts.chivo(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: currentPage == 2
                                    ? kPrimaryColor
                                    : Color.fromARGB(255, 129, 129, 129),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = 3;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 30,
                                  width: currentPage == 3
                                      ? MediaQuery.of(context).size.width * 0.18
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      EvaIcons.message_circle_outline,
                                      color: currentPage == 3
                                          ? kPrimaryColor
                                          : Color.fromARGB(255, 129, 129, 129),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Chat',
                              style: GoogleFonts.chivo(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: currentPage == 3
                                    ? kPrimaryColor
                                    : Color.fromARGB(255, 129, 129, 129),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = 4;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 30,
                                  width: currentPage == 4
                                      ? MediaQuery.of(context).size.width * 0.18
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      EvaIcons.person_outline,
                                      color: currentPage == 4
                                          ? kPrimaryColor
                                          : Color.fromARGB(255, 129, 129, 129),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Profile',
                              style: GoogleFonts.chivo(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: currentPage == 4
                                    ? kPrimaryColor
                                    : Color.fromARGB(255, 129, 129, 129),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      body: pages[currentPage],
    );
  }
}
