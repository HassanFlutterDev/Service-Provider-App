// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:abid/frontend/client/catagory/catagory_client.dart';
import 'package:abid/frontend/labor/booking/booking_screen.dart';
import 'package:abid/frontend/manager/allbookings/all_booking.dart';
import 'package:abid/frontend/manager/allservice/all_service.dart';
import 'package:abid/frontend/manager/labors/labors_screen.dart';
import 'package:abid/frontend/manager/service%20Detail/service_Details.dart';
import 'package:abid/frontend/manager/serviceRequest/request_screen.dart';
import 'package:abid/frontend/manager/services/services_screen.dart';
import 'package:abid/frontend/manager/users/users.dart';
import 'package:abid/frontend/selection/selection_screen.dart';
import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class home_manager extends StatefulWidget {
  const home_manager({super.key});

  @override
  State<home_manager> createState() => _home_managerState();
}

class _home_managerState extends State<home_manager> {
  bool isLoading = false;
  var userData = {};
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
          .collection('Admin')
          .doc('Admin')
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
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 130,
                color: kPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: kPrimaryColor,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.S2talWxT3helOwohXM7czwHaJQ?pid=ImgDet&w=800&h=1000&rs=1'),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  isLoading
                                      ? 'Loading..'
                                      : userData['username'],
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.chivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  isLoading ? 'Loading..' : userData['email'],
                                  style: GoogleFonts.chivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  'Dashboard',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(request_Screen(), transition: Transition.downToUp);
                },
                leading: Icon(
                  EvaIcons.plus,
                  color: Colors.black,
                ),
                title: Text(
                  'Service Requests',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(AllServiceManager(), transition: Transition.downToUp);
                },
                leading: Icon(
                  Icons.handyman_sharp,
                  color: Colors.black,
                ),
                title: Text(
                  'Services',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(AllLaborsManager(), transition: Transition.downToUp);
                },
                leading: Icon(
                  EvaIcons.person_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Labors',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(AllBookingManager(), transition: Transition.downToUp);
                },
                leading: Icon(
                  FontAwesome.ticket,
                  color: Colors.black,
                ),
                title: Text(
                  'Booking',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(AllUsersManager(), transition: Transition.downToUp);
                },
                leading: Icon(
                  EvaIcons.person_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Users',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  EvaIcons.info_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'About Us',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  EvaIcons.phone_call_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Helpline Number',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.to(selection_screen());
                  });
                },
                leading: Icon(
                  EvaIcons.log_out,
                  color: Colors.black,
                ),
                title: Text(
                  'LogOut',
                  style: GoogleFonts.chivo(
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Dashboard',
          style: GoogleFonts.chivo(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello, ${isLoading ? 'Loading..' : userData['username']}',
                    style: GoogleFonts.chivo(
                      fontSize: 20,
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
                                    ? 'Loading..'
                                    : userData['labors'].length.toString(),
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
                                  EvaIcons.person_outline,
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
                                'Labors',
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
                                    ? 'Loading..'
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
                                'Services',
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
                                    ? 'Loading..'
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
                                    ? 'Loading..'
                                    : userData['users'].length.toString(),
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
                                  EvaIcons.person_outline,
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
                                'Users',
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
            Container(
              height: 260,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.07),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Labors',
                          style: GoogleFonts.chivo(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(AllLaborsManager(),
                                transition: Transition.downToUp);
                          },
                          child: Text(
                            'View All',
                            style: GoogleFonts.chivo(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 223,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('isLabor', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var snap = snapshot.data!.docs[index].data();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      snap['photoUrl']),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                snap['username'],
                                                style: GoogleFonts.chivo(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                    text: snap['number']))
                                                .then((result) {
                                              // show toast or snackbar after successfully save
                                              Showsnackbar(context,
                                                  'Phone Number Successfully Copied!');
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: kPrimaryColor
                                                    .withOpacity(0.7),
                                                child: Icon(
                                                  EvaIcons.phone_call_outline,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Clipboard.setData(
                                                          ClipboardData(
                                                              text: snap[
                                                                  'email']))
                                                      .then((result) {
                                                    // show toast or snackbar after successfully save
                                                    Showsnackbar(context,
                                                        'Email Successfully Copied!');
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor: kPrimaryColor
                                                      .withOpacity(0.7),
                                                  child: Icon(
                                                    EvaIcons.email_outline,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      });
                                                  try {
                                                    var getuser =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(snap['uid'])
                                                            .get();
                                                    for (var i = 0;
                                                        i <
                                                            getuser
                                                                .data()![
                                                                    'services']
                                                                .length;
                                                        i++) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'services')
                                                          .doc(getuser.data()![
                                                              'services'][i])
                                                          .delete();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Admin')
                                                          .doc('Admin')
                                                          .update({
                                                        'services': FieldValue
                                                            .arrayRemove([
                                                          getuser.data()![
                                                              'services'][i]
                                                        ]),
                                                      });
                                                    }
                                                    for (var i = 0;
                                                        i <
                                                            getuser
                                                                .data()![
                                                                    'bookings']
                                                                .length;
                                                        i++) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'bookings')
                                                          .doc(getuser.data()![
                                                              'bookings'][i])
                                                          .delete();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Admin')
                                                          .doc('Admin')
                                                          .update({
                                                        'bookings': FieldValue
                                                            .arrayRemove([
                                                          getuser.data()![
                                                              'bookings'][i]
                                                        ]),
                                                      });
                                                    }
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Admin')
                                                        .doc('Admin')
                                                        .update({
                                                      'labors': FieldValue
                                                          .arrayRemove(
                                                              [snap['uid']]),
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(snap['uid'])
                                                        .delete();
                                                    UserCredential
                                                        userCredential =
                                                        await FirebaseAuth
                                                            .instance
                                                            .signInWithEmailAndPassword(
                                                                email: snap[
                                                                    'email'],
                                                                password: snap[
                                                                    'password']);

                                                    log(FirebaseAuth.instance
                                                        .currentUser!.uid);
                                                    userCredential.user!
                                                        .delete();
                                                    UserCredential userCred =
                                                        await FirebaseAuth
                                                            .instance
                                                            .signInWithEmailAndPassword(
                                                                email:
                                                                    'admin@gmail.com',
                                                                password:
                                                                    'OLHAdmin123@');
                                                    log(FirebaseAuth.instance
                                                        .currentUser!.uid);
                                                    Get.back();
                                                    Showsnackbar(context,
                                                        'Labor Successfully Deleted');
                                                    // .deleteuser(); // called from database class
                                                    // await result.user!.delete();
                                                  } catch (e) {
                                                    log(e.toString());
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.7),
                                                  child: Icon(
                                                    EvaIcons
                                                        .person_remove_outline,
                                                    color: Colors.white,
                                                  ),
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
                    'New Services',
                    style: GoogleFonts.chivo(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AllServiceManager(),
                          transition: Transition.downToUp);
                    },
                    child: Text(
                      'View All',
                      style: GoogleFonts.chivo(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
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
                        itemCount: snapshot.data!.docs.length <= 2
                            ? snapshot.data!.docs.length
                            : 2,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Bookings',
                    style: GoogleFonts.chivo(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AllBookingManager(),
                          transition: Transition.downToUp);
                    },
                    child: Text(
                      'View All',
                      style: GoogleFonts.chivo(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('bookings')
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
                          return GestureDetector(
                            onTap: () {
                              // Get.to(
                              //     booking_detail_labor(
                              //         Bid: snap['bid'],
                              //         Sid: snap['Sid'],
                              //         url: snap['url'],
                              //         address: snap['address'],
                              //         date: snap['date'],
                              //         disc: snap['disc'],
                              //         id: snap['id'],
                              //         laborImage: snap['clientImage'],
                              //         laborName: snap['clientName'],
                              //         laborUid: snap['clientUid'],
                              //         name: snap['name'],
                              //         status: snap['status']),
                              //     transition: Transition.downToUp);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                height: 260,
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
                                                            fit: BoxFit.cover)),
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
                                                      decoration: BoxDecoration(
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
                                                          style:
                                                              GoogleFonts.chivo(
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
                                                                FontWeight.w600,
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
                                                      style: GoogleFonts.chivo(
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
                                                      style: GoogleFonts.chivo(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${snap['price']} PKR',
                                                      style: GoogleFonts.chivo(
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
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
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
                                                    'Client',
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
                                                    snap['clientName'],
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
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
