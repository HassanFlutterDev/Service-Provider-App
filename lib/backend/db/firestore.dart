import 'dart:io';

import 'package:abid/backend/storage/firebase_stroaege.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class firestore extends GetxController {
  Future sendServicetoAdmin(
    BuildContext context,
    String name,
    String disc,
    String price,
    String dur,
    String catagory,
    String uid,
    String city,
    String path,
    String username,
    String userimage,
  ) async {
    try {
      String id = Uuid().v1();
      String url = await storage().UploadFile(File(path), id);
      await FirebaseFirestore.instance
          .collection('Admin')
          .doc('Admin')
          .collection('requests')
          .doc(id)
          .set({
        'name': name,
        'id': id,
        'disc': disc,
        'price': price,
        'duration': dur,
        'catagory': catagory,
        'uid': uid,
        'City': city,
        'url': url,
        'username': username,
        'userImage': userimage,
      });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }
}
