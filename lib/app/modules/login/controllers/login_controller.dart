// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tugas10/TokenManager.dart';
import 'package:tugas10/app/routes/app_pages.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  // FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('User');

  Future<void> login(
    String username,
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

    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('username', isEqualTo: username)
        .limit(1) // Batasi hanya 1 dokumen yang akan diambil
        .get();
    if (querySnapshot.docs.isEmpty) {
      Get.snackbar(
        "Error",
        "Username tidak ditemukan",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    } // Mengambil dokumen pertama yang ditemukan
    final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

    // Mendapatkan hash password dari data pengguna di Firestore
    final storedPasswordHash = userData['password'] as String;
    if (passwordhash == storedPasswordHash) {
      // Jika cocok, tampilkan pesan sukses
      Get.snackbar(
        "Success",
        "Login berhasil",
      );
      await TokenManager.generateToken(username);
      Get.offAllNamed(Routes.HOME);
      // Lakukan navigasi ke halaman selanjutnya, atau lakukan sesuatu setelah login berhasil
    } else {
      // Jika tidak cocok, tampilkan pesan error
      Get.snackbar(
        "Error",
        "Password salah",
      );
    }
    // saya ingin melakukan login, mencari username dan password
    // final refDoc = ref.doc();
    // final data = {
    //   "id": refDoc.id,
    //   "username": username,
    //   "name": name,
    //   "address": address,
    //   "phone": phone,
    //   "password": passwordhash,
    // };
    // refDoc.set(data);
  }

  // Stream<User?> get streamAuthStatus =>
  //     FirebaseAuth.instance.authStateChanges();

  // void login(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     if (userCredential.user!.emailVerified) {
  //       Get.snackbar('Success', 'User logged in successfully');
  //       Get.offAllNamed(Routes.HOME);
  //     } else {
  //       Get.snackbar('Error', 'Please verify your email');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('wrong email');
  //       Get.snackbar('Error', 'No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('wrong password');
  //       Get.snackbar('Error', 'Wrong password provided for that user.');
  //     } else if (e.code == 'too-many-requests') {
  //       print('too-many-requests');
  //       Get.snackbar('Error', 'Too many requests. Try again later.');
  //     }
  //     print(e.code);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
