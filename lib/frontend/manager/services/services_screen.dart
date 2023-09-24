// ignore_for_file: prefer_const_constructors

import 'package:abid/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class service_manager extends StatefulWidget {
  const service_manager({super.key});

  @override
  State<service_manager> createState() => _service_managerState();
}

class _service_managerState extends State<service_manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'All-Services',
          style: GoogleFonts.chivo(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
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
                              image: NetworkImage(
                                  'https://th.bing.com/th/id/R.48b343524cc84ee7bcf3fceff71453f6?rik=R%2bEY9cWx3PbnRg&pid=ImgRaw&r=0'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 145,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Home Labor',
                                  style: GoogleFonts.chivo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '★★★★★',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  '2 Bookings',
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
                              'I am a Home Labor with 2 year Experience. I have done Many Projects. I am good in building a House',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.chivo(
                                color: Color.fromARGB(255, 60, 60, 60),
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
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
                            image: NetworkImage(
                                'https://th.bing.com/th/id/R.168bf459952cf33127bb10b503cc5a04?rik=xmI3QN8WgI8Z0A&riu=http%3a%2f%2fblogmedia.dealerfire.com%2fwp-content%2fuploads%2fsites%2f478%2f2016%2f06%2fbigstock-Portrait-of-an-auto-mechanic-a-91601333.jpg&ehk=oUcyeT%2fuDgjCN8qv5vYIzqT3HmsKzjLqJodnbpv8ecs%3d&risl=&pid=ImgRaw&r=0'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width - 145,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Home Mechanic',
                                style: GoogleFonts.chivo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '★★★★★',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                '1 Bookings',
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
                            'I am a Home Mechanic with 2 year Experience. I have done Many Projects. I am good in building a Cicuit',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.chivo(
                              color: Color.fromARGB(255, 60, 60, 60),
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
        ],
      ),
    );
  }
}
