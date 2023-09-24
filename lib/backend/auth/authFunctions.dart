import 'package:abid/theme/theme.dart';
import 'package:abid/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFunction extends GetxController {
  static AuthFunction instance = Get.find();

  Future<String> Signup(
      String email,
      String password,
      String username,
      String lastName,
      String firstName,
      String number,
      bool isLabor,
      BuildContext context) async {
    String err = '';
    try {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Creating Account', 'Success',
          overlayColor: kPrimaryColor,
          backgroundColor: kPrimaryColor.withOpacity(1),
          colorText: Colors.white);
      String? token = await FirebaseMessaging.instance.getToken();
      String? descc;
      List<String> splitList = username.split(" ");
      // List<String> splitList1 = username.split("");
      List<String> searchIndex = [];
      searchIndex.add(username.toLowerCase());
      searchIndex.add(username.toUpperCase());
      searchIndex.add(username.replaceAll(" ", ''));
      searchIndex.add(username.split(" ").removeLast());

      for (var i = 0; i < splitList.length; i++) {
        for (var y = 0; y < splitList[i].length; y++) {
          searchIndex.add(splitList[i].substring(0, y + 1).toLowerCase());
          searchIndex.add(splitList[i].substring(0, y + 1));
          searchIndex.add(splitList[i].substring(0, y + 1).toUpperCase());
        }
      }
      isLabor == true
          ? await FirebaseFirestore.instance
              .collection('users')
              .doc(cred.user!.uid)
              .set({
              'username': username,
              'lastName': lastName,
              'firstName': firstName,
              'isLabor': true,
              'number': number,
              'services': [],
              'token': token,
              'password': password,
              'bookings': [],
              'email': email,
              'date': DateTime.now(),
              'about': 'Nothing',
              'searchIndex': searchIndex,
              'uid': cred.user!.uid,
              'photoUrl':
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU',
            })
          : await FirebaseFirestore.instance
              .collection('users')
              .doc(cred.user!.uid)
              .set({
              'username': username,
              'isLabor': false,
              'number': number,
              'lastName': lastName,
              'firstName': firstName,
              'token': token,
              'password': password,
              'bookings': [],
              'email': email,
              'like': [],
              'searchIndex': searchIndex,
              'uid': cred.user!.uid,
              'photoUrl':
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU',
            });
      isLabor == true
          ? await FirebaseFirestore.instance
              .collection('Admin')
              .doc('Admin')
              .update({
              'labors': FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser!.uid]),
            })
          : await FirebaseFirestore.instance
              .collection('Admin')
              .doc('Admin')
              .update({
              'users': FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser!.uid]),
            });
      // Get.to(homePgae(), transition: Transition.rightToLeft);
      if (password.isEmpty && username.isEmpty && email.isEmpty) {
        err = 'fields-error';
        Showsnackbar(context, 'Please fill all fields');
      }
    } on FirebaseAuthException catch (e) {
      Showsnackbar(context, e.message!);
      print(e.code);
      if (e.code == 'weak-password') {
        err = "password-error";

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        err = "email-error";
      } else if (e.code == 'invalid-email') {
        err = "invalid-email";
      } else if (e.code == 'unknown') {
        err = "fields-error";
      } else if (e.code == 'network-request-failed') {
        err = "network-error";
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
      // Get.snackbar('Error in Creating Account', e.toString(),
      //     overlayColor: Colors.purple,
      //     backgroundColor: Colors.purple.shade200,
      //     colorText: Colors.white);
    }
    return err;
  }

  Future<String> loginUser(
      String email, String password, BuildContext context) async {
    String err2 = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "token": token,
      });
      print("Login done");
      ;
      // Get.to(homePgae(), transition: Transition.rightToLeft);

      // Get.snackbar('Error', 'Please Fill All Fields',
      //     overlayColor: Colors.purple,
      //     backgroundColor: Colors.purple.shade200,
      //     colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Showsnackbar(context, e.message!);
      print(e.code);
      if (e.code == 'user-not-found') {
        err2 = 'error-user';
      } else if (e.code == 'wrong-password') {
        err2 = 'error-pass';
      } else if (e.code == 'invalid-email') {
        err2 = "invalid-email";
      } else if (e.code == 'unknown') {
        err2 = "fields-error";
      } else if (e.code == 'network-request-failed') {
        err2 = "network-error";
      } else if (e.code == 'too-many-requests') {
        err2 = "network-error";
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return err2;
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {}
    return false;
  }
}
