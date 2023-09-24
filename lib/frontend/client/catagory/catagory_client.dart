import 'package:abid/frontend/client/catagoryScreen/catagory_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class catagory_client extends StatefulWidget {
  const catagory_client({super.key});

  @override
  State<catagory_client> createState() => _catagory_clientState();
}

class _catagory_clientState extends State<catagory_client> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Catagory',
          style: GoogleFonts.chivo(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[0]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[0]),
                      ),
                      Text(
                        names[0],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[1]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[1]),
                      ),
                      Text(
                        names[1],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[2]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[2]),
                      ),
                      Text(
                        names[2],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[3]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[3]),
                      ),
                      Text(
                        names[3],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[4]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[4]),
                      ),
                      Text(
                        names[4],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    catagory_details(catagory: catagi[5]),
                    transition: Transition.downToUp,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(image[5]),
                      ),
                      Text(
                        names[5],
                        style: GoogleFonts.chivo(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
