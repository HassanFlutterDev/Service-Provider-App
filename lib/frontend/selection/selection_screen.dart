// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:abid/frontend/client/login/login_screen.dart';
import 'package:abid/frontend/labor/login/login_screen.dart';
import 'package:abid/frontend/manager/login/login_screen.dart';
import 'package:abid/services/services.dart';
import 'package:abid/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class selection_screen extends StatefulWidget {
  const selection_screen({super.key});

  @override
  State<selection_screen> createState() => _selection_screenState();
}

class _selection_screenState extends State<selection_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          CupertinoButton(
              child: Text('Manager'),
              onPressed: () {
                Get.to(manager_login_screen(), transition: Transition.downToUp);
              }),
        ],
      ),
      // backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/olh_icon.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Join as a Labor or Client.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(login_labor(), transition: Transition.downToUp);
                },
                child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 244, 244),
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: kPrimaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 4),
                            spreadRadius: 1,
                            blurRadius: 7,
                            color: Color.fromARGB(255, 192, 192, 192))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        color: Colors.transparent,
                        child: Image.asset(
                          'images/worker.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Labor',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(client_login_screen(),
                      transition: Transition.downToUp);
                },
                child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 244, 244),
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: kPrimaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-3, 4),
                            spreadRadius: 1,
                            blurRadius: 7,
                            color: Color.fromARGB(255, 192, 192, 192))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        color: Colors.transparent,
                        child: Image.asset(
                          'images/client1.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Client',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
