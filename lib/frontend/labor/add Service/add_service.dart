// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:abid/services/services.dart';
import '../../../backend/db/firestore.dart';

class add_service_labor extends StatefulWidget {
  String name;
  String url;
  add_service_labor({super.key, required this.name, required this.url});

  @override
  State<add_service_labor> createState() => _add_service_laborState();
}

class _add_service_laborState extends State<add_service_labor> {
  String? valuechanges;
  List catagi = [
    "Electrician",
    "Mechanic",
    "Plumber",
    "Daily Wages Labor",
    "Painter",
    "Car Painter",
  ];
  PlatformFile? file;
  TextEditingController name = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController dur = TextEditingController();
  bool loading = false;
  bool sended = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add-Service',
            style: GoogleFonts.chivo(
              fontWeight: FontWeight.w400,
              fontSize: 21,
              color: Colors.white,
            )),
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
                    'Your Service is in Under Review!',
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
              child: Column(
                children: [
                  file != null
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: FileImage(File(file!.path!)),
                                fit: BoxFit.cover),
                          ))
                      : Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () async {
                              var result = await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );
                              setState(() {
                                file = result!.files.first;
                              });
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    EvaIcons.camera_outline,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Add Image',
                                    style: GoogleFonts.chivo(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Service Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: disc,
                        maxLines: 4,
                        minLines: 1,
                        maxLength: 600,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Price (PKR)',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: dur,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Duration (Hours)',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.07),
                      borderRadius: BorderRadius.circular(15),
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
                                  hint: Text("Select Catagory"),
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
                  loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : CupertinoButton(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kPrimaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Add-Service',
                                style: GoogleFonts.chivo(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              Geolocator.requestPermission();
                              if (!await Geolocator
                                  .isLocationServiceEnabled()) {
                                Get.back();

                                Showsnackbar(context,
                                    'Please Enable Your Location Services');
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                if (name.text.isEmpty) {
                                  Showsnackbar(
                                      context, 'Please Fill The All Fields');
                                  setState(() {
                                    loading = false;
                                  });
                                } else if (disc.text.isEmpty) {
                                  Showsnackbar(
                                      context, 'Please Fill The All Fields');
                                  setState(() {
                                    loading = false;
                                  });
                                } else if (price.text.isEmpty) {
                                  Showsnackbar(
                                      context, 'Please Fill The All Fields');
                                  setState(() {
                                    loading = false;
                                  });
                                } else if (dur.text.isEmpty) {
                                  Showsnackbar(
                                      context, 'Please Fill The All Fields');
                                  setState(() {
                                    loading = false;
                                  });
                                } else if (file == null) {
                                  Showsnackbar(
                                      context, 'Please Pick the Image');
                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  var Usersnap = await FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get();
                                  if (Usersnap.data()!['services'].length >=
                                      2) {
                                    Showsnackbar(context,
                                        'Sorry you cann\'t add Upto 2 services');
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

                                    await firestore().sendServicetoAdmin(
                                      context,
                                      name.text,
                                      disc.text,
                                      price.text,
                                      dur.text,
                                      valuechanges!,
                                      FirebaseAuth.instance.currentUser!.uid,
                                      placemark[0].locality!,
                                      file!.path!,
                                      widget.name,
                                      widget.url,
                                    );

                                    setState(() {
                                      loading = false;
                                      sended = true;
                                    });
                                  }
                                }
                              }
                            } catch (e) {
                              Showsnackbar(context, e.toString());
                              setState(() {
                                loading = false;
                              });
                            }
                          }),
                ],
              ),
            ),
    );
  }
}
