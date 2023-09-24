// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_is_empty, dead_code

import 'dart:developer';

import 'package:abid/frontend/client/catagoryScreen/catagory_details.dart';
import 'package:abid/frontend/client/search/search_screen.dart';
import 'package:abid/frontend/client/service/service_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class home_client extends StatefulWidget {
  const home_client({super.key});

  @override
  State<home_client> createState() => _home_clientState();
}

class _home_clientState extends State<home_client> {
  List imageList = [
    {"id": 1, "image_path": 'images/mechanicI.jpg'},
    {"id": 2, "image_path": 'images/mechanicI1.jpg'},
    {"id": 3, "image_path": 'images/laborI.jpg'}
  ];
  List image = [
    'images/electric.png',
    'images/plumber.png',
    'images/labor.png',
    'images/mechanic.png',
    'images/painter.png',
    'images/carP.png',
  ];
  List names = [
    'Electrician',
    'Plumber',
    'Labor',
    'Mechanic',
    'Painter',
    'Car Painter',
  ];
  List catagi = [
    "Electrician",
    "Plumber",
    "Daily Wages Labor",
    "Mechanic",
    "Painter",
    "Car Painter",
  ];
  final CarouselController carouselController = CarouselController();
  bool show = false;
  bool loading = true;
  String city = '';
  String location = '';
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      setState(() {
        loading = false;
      });
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: imageList
                      .map(
                        (item) => Image.asset(
                          item['image_path'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 300,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? kPrimaryColor
                                  : Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 300,
                      // color: ,/
                      child: Card(
                        color: Color.fromARGB(255, 255, 255, 255),
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Color.fromARGB(255, 64, 64, 64),
                            ),
                            Text(
                              show ? location : 'All Services Available',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: show ? 14 : 17,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (show) {
                                  setState(() {
                                    show = false;
                                    location = '';
                                    city = '';
                                  });
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  Geolocator.requestPermission();
                                  if (!await Geolocator
                                      .isLocationServiceEnabled()) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Showsnackbar(context,
                                        'Please Enable Your Location Services');
                                  } else {
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                      desiredAccuracy:
                                          LocationAccuracy.bestForNavigation,
                                    );
                                    List<Placemark> placemark =
                                        await placemarkFromCoordinates(
                                            position.latitude,
                                            position.longitude);
                                    log(placemark.toString());
                                    log(placemark[0].country!);
                                    log(placemark[0].locality!);
                                    setState(() {
                                      show = true;
                                      city = placemark[0].locality!;
                                      location =
                                          '${placemark[0].name!},${placemark[0].locality!},${placemark[0].country!}';
                                    });
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Icon(
                                FontAwesome.location_crosshairs,
                                color: Color.fromARGB(255, 107, 107, 107),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          SearchScreen(),
                          transition: Transition.downToUp,
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        // color: ,/
                        child: Card(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Center(
                            child: Icon(
                              EvaIcons.search,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Catagories',
                        style: GoogleFonts.chivo(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 110,
                  color: Colors.transparent,
                  child: ListView.builder(
                      itemCount: image.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(catagory_details(catagory: catagi[index]),
                                transition: Transition.downToUp);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 34,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(image[index]),
                                ),
                                Text(
                                  names[index],
                                  style: GoogleFonts.chivo(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 380,
                  color: kPrimaryColor.withOpacity(0.15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Services',
                              style: GoogleFonts.chivo(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                SearchScreen(),
                                transition: Transition.downToUp,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'View All',
                                style: GoogleFonts.chivo(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 310,
                        color: Colors.transparent,
                        child: StreamBuilder(
                            stream: show
                                ? FirebaseFirestore.instance
                                    .collection('services')
                                    .where('city', isEqualTo: city)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('services')
                                    .snapshots(),
                            builder: (context, snapshot) {
                              if (loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var snap =
                                        snapshot.data!.docs[index].data();
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
                                          height: 300,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snap['url']),
                                                            fit: BoxFit.cover),
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${rating(snap['star1'], snap['star2'], snap['star3'], snap['star4'], snap['star5'])}★',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .greenAccent,
                                                            fontSize: 17,
                                                          ),
                                                        )
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
                                                          snap['name']
                                                                      .toString()
                                                                      .length <=
                                                                  30
                                                              ? snap['name']
                                                              : snap['name']
                                                                  .toString()
                                                                  .replaceRange(
                                                                      28,
                                                                      snap['name']
                                                                          .toString()
                                                                          .length,
                                                                      '..'),
                                                          style:
                                                              GoogleFonts.chivo(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 6),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(snap[
                                                                  'userImage']),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          snap['username'],
                                                          style:
                                                              GoogleFonts.chivo(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 160),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 30,
                                                        width: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kPrimaryColor,
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            snap['price'],
                                                            style: GoogleFonts
                                                                .chivo(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
