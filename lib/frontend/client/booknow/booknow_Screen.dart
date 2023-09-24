// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'dart:developer';
import 'dart:math';

import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import 'package:uuid/uuid.dart';

class BookNowScreen extends StatefulWidget {
  String uid;
  String name;
  String url;
  String price;
  String catgory;
  String id;
  BookNowScreen({
    super.key,
    required this.catgory,
    required this.name,
    required this.price,
    required this.uid,
    required this.url,
    required this.id,
  });

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String date = 'Pick date and time';
  var userData = {};
  var laborData = {};
  bool isLoading = false;
  TextEditingController disc = TextEditingController();
  TextEditingController address = TextEditingController();
  String error = '';
  String derror = '';
  String aerror = '';
  bool loading = false;
  bool sended = false;
  @override
  void initState() {
    super.initState();
    getData();
    getLaborData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  getLaborData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      setState(() {
        laborData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  ProductModel element = ProductModel("Product 1", "100");
  bool jazz = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              EvaIcons.arrow_ios_back,
              color: Colors.white,
            )),
        title: Text(
          'Book Now',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: sended
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Booking is Successfully Sended to Labor!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Enter Detail Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 420,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 242, 242),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              'Date And Time:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // String time1 = '';/
                          DateTime? time = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025, 9, 7, 17, 30));
                          TimeOfDay? time1 = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          setState(() {
                            date =
                                '${DateFormat.yMMMd().format(time!)} ${time1!.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')} ${time1.period.toString().split('.')[1]}';
                            print(time1
                                .toString()
                                .replaceAll('TimeOfDay(', '')
                                .replaceAll(')', ''));
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: error != ''
                                  ? Colors.red
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.07),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(
                                    EvaIcons.calendar_outline,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      error == ''
                          ? Container()
                          : Text(error,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              'Your Address:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            color: aerror != ''
                                ? Colors.red
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.07),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            maxLines: 2,
                            minLines: 1,
                            controller: address,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add Address',
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                )),
                          ),
                        ),
                      ),
                      aerror == ''
                          ? Container()
                          : Text(aerror,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                      TextButton(
                          onPressed: () async {
                            Geolocator.requestPermission();
                            if (!await Geolocator.isLocationServiceEnabled()) {
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
                                      position.latitude, position.longitude);
                              // log(placemark.toString());
                              // log(placemark[0].country!);
                              // log(placemark[0].locality!);
                              setState(() {
                                address.text =
                                    '${placemark[0].name!},${placemark[0].subLocality!},${placemark[0].locality!},${placemark[0].country!}';
                              });
                            }
                          },
                          child: Text(
                            'Use Current Location',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              'Description:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 40,
                        // margin: EdgeInsets.symmetric(horizontal: 12),
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey.shade400, width: 2),
                            color: derror != ''
                                ? Colors.red
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.07),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            controller: disc,
                            maxLines: 2,
                            minLines: 1,
                            maxLength: 600,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description',
                            ),
                          ),
                        ),
                      ),
                      derror == ''
                          ? Container()
                          : Text(derror,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Info And Price',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 360,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 242, 242),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 120,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(widget.url),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.07),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.price_check_outlined,
                                  size: 25,
                                ),
                                Text(
                                  '${widget.price} PKR',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            jazz = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    jazz == false ? Colors.green : Colors.grey,
                              ),
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.07),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    jazz == false
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    size: 25,
                                    color: jazz == false
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Cash on Delivery',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: jazz == false
                                          ? Colors.green
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            jazz = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    jazz == true ? Colors.green : Colors.grey,
                              ),
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.07),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    jazz == true
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    size: 25,
                                    color: jazz == true
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'JazzCash',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: jazz == true
                                          ? Colors.green
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      loading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : CupertinoButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              onPressed: () async {
                                if (jazz == false) {
                                  if (date == 'Pick date and time') {
                                    setState(() {
                                      error = 'Add date and time';
                                      derror = '';
                                      aerror = '';
                                    });
                                  } else if (disc.text.isEmpty) {
                                    setState(() {
                                      derror = 'Fill the Discription';
                                      error = '';
                                      aerror = '';
                                    });
                                  } else if (address.text.isEmpty) {
                                    setState(() {
                                      aerror = 'Add your address';
                                      derror = '';
                                      error = '';
                                    });
                                  } else if (date == 'Pick date and time') {
                                    setState(() {
                                      error = 'Add date and time';
                                      derror = '';
                                      aerror = '';
                                    });
                                  } else {
                                    setState(() {
                                      error = '';
                                      derror = '';
                                      aerror = '';
                                      loading = true;
                                    });
                                    String id = Uuid().v1();
                                    String bId =
                                        Random().nextInt(9999).toString();
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.uid)
                                        .update({
                                      'bookings': FieldValue.arrayUnion([id]),
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('Admin')
                                        .doc('Admin')
                                        .update({
                                      'bookings': FieldValue.arrayUnion([id]),
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('services')
                                        .doc(widget.id)
                                        .update({
                                      'bookings': FieldValue.arrayUnion([id]),
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('bookings')
                                        .doc(id)
                                        .set({
                                      'name': widget.name,
                                      'disc': disc.text,
                                      'date': date,
                                      'uids': [
                                        FirebaseAuth.instance.currentUser!.uid,
                                        widget.uid,
                                      ],
                                      'address': address.text,
                                      'url': widget.url,
                                      'id': bId,
                                      'Sid': widget.id,
                                      'bid': id,
                                      'price': widget.price,
                                      'laborName': laborData['username'],
                                      'laborImage': laborData['photoUrl'],
                                      'clientName': userData['username'],
                                      'clientImage': userData['photoUrl'],
                                      'clientUid': userData['uid'],
                                      'laborUid': laborData['uid'],
                                      'status': 'Pending',
                                    });
                                    setState(() {
                                      sended = true;
                                    });
                                  }
                                } else {
                                  try {
                                    JazzCashFlutter jazzCashFlutter =
                                        JazzCashFlutter(
                                      merchantId: "MC57368",
                                      merchantPassword: "",
                                      integritySalt: "Your Integrity Salt here",
                                      isSandbox: true,
                                    );

                                    DateTime date = DateTime.now();

                                    JazzCashPaymentDataModelV1
                                        paymentDataModelV1 =
                                        JazzCashPaymentDataModelV1(
                                      ppAmount: '${element.productPrice}',
                                      ppBillReference:
                                          'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
                                      ppDescription:
                                          'Product details  ${element.productName} - ${element.productName}',
                                      ppMerchantID: "MC57368",
                                      ppPassword: "",
                                      ppReturnURL: "",
                                    );

                                    jazzCashFlutter
                                        .startPayment(
                                            paymentDataModelV1:
                                                paymentDataModelV1,
                                            context: context)
                                        .then((_response) {
                                      // _checkIfPaymentSuccessfull(
                                      //         _response, element, context)
                                      //     .then((res) {
                                      //   // res is the response you returned from ;
                                      //   return res;
                                      // });

                                      setState(() {});
                                    });
                                  } catch (err) {
                                    print("Error in payment $err");
                                    // CommonFunctions.CommonToast(
                                    //   message: "Error in payment $err",
                                    // );
                                    // return false;
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kPrimaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Book Now',
                                    style: GoogleFonts.chivo(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}

class ProductModel {
  String? productName;
  String? productPrice;

  ProductModel(this.productName, this.productPrice);
}
