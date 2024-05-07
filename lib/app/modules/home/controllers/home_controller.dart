import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas10/TokenManager.dart';
import 'package:tugas10/UserImage.dart';
import 'package:tugas10/app/routes/app_pages.dart';
// import 'package:tugas10/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  String imageUrl = "";
  CollectionReference ref = FirebaseFirestore.instance.collection('User');
  CollectionReference refImg = FirebaseFirestore.instance.collection('Images');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentSnapshot<Object?>> getData() async {
    String? username = await TokenManager.getToken();
    QuerySnapshot querySnapshot =
        await ref.where('username', isEqualTo: username).get();

    DocumentReference docRef =
        firestore.collection('User').doc(querySnapshot.docs.first.id);
    return docRef.get();
  }

  Future<void> getImage(bool gallery) async {
    String? username = await TokenManager.getToken();
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    final referenceRoot = FirebaseStorage.instance.ref();
    final referenceDirImage = referenceRoot.child('images');

    final referenceImageToOpload = referenceDirImage.child(uniqueFileName);
    try {
      await referenceImageToOpload.putFile(File(file!.path));
      imageUrl = await referenceImageToOpload.getDownloadURL();

      final refDoc = refImg.doc();
      //upload data resep ke dalam firestore dan simpan url gambar yang sudah diuplo
      final data = {"id": refDoc.id, "images": imageUrl, "username": username};
      refDoc.set(data);

      Get.back();
    } catch (error) {}
  }

  void logout() async {
    TokenManager.deleteToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
