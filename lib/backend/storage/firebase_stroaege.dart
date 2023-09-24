import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class storage extends GetxController {
  UploadTask? task;
  Future<String> UploadFile(File file, String postId) async {
    String? downloadurl;
    try {
      // var postId = Uuid().v1();

      Reference ref =
          FirebaseStorage.instance.ref().child('files').child(postId);

      task = ref.putFile(
        file,
      );

      TaskSnapshot snap = await task!;
      downloadurl = await snap.ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('error 2 ', e.toString());
    }
    return downloadurl!;
  }
}
