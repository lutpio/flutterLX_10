import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
// import 'package:tugas10/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('User');

  Future<bool> isUsernameExists(String username) async {
    // Membuat query untuk mencari dokumen dengan field 'username' yang sesuai
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('username', isEqualTo: username)
        .get();

    // Jika jumlah dokumen yang ditemukan lebih dari 0, berarti username sudah ada
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> saveUser(
    String username,
    String name,
    String address,
    String phone,
    String password,
  ) async {
    Get.bottomSheet(
      Container(
          height: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          )),
    );
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    final passwordhash = hash.toString();

    final refDoc = ref.doc();
    final data = {
      "id": refDoc.id,
      "username": username,
      "name": name,
      "address": address,
      "phone": phone,
      "password": passwordhash,
    };
    refDoc.set(data);
  }

  @override
  void onClose() {
    usernameController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    super.onClose();
  }
}
