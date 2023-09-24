import 'dart:ui';

import 'package:abid/frontend/labor/booking/booking_screen.dart';
import 'package:abid/frontend/labor/chat/chat_labor.dart';
import 'package:abid/frontend/labor/home/home_screen.dart';
import 'package:abid/frontend/labor/profile/profile_labor.dart';
import 'package:abid/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class bottom_labor extends StatefulWidget {
  const bottom_labor({super.key});

  @override
  State<bottom_labor> createState() => _bottom_laborState();
}

class _bottom_laborState extends State<bottom_labor> {
  int currentIndex = 0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      home_labor(),
      booking_labor(),
      chat_labor(),
      profile_labor(),
    ];
    return Scaffold(
      body: pages[currentPage],
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
                                      EvaIcons.message_circle_outline,
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
                              'Chat',
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
                                      EvaIcons.person_outline,
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
                              'Profile',
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
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
