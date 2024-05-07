import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tugas10/UserImage.dart';

class ShowController extends GetxController {
  //TODO: Implement ShowController

  Stream<List<UserImage>> readImage(String username) {
    return FirebaseFirestore.instance
        .collection('Images')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserImage.fromJson(doc.data()))
            .toList());
  }
}
