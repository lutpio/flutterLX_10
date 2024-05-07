// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:tugas10/UserImage.dart';
import 'package:tugas10/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  // String imageUrl='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                var data2 = snapshot.data!;
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(212, 212, 212, 1)),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: 160,
                          // color: Colors.amber,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello ${data2['name']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(51, 65, 85, 1),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "How's your day going?",
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 65, 85, 1),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.logout();
                                          },
                                          icon: const Icon(Icons.person),
                                        ))),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          // color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Phone Number : ${data2['phone']}",
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 65, 85, 1),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "My Address : ${data2['address']}",
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 65, 85, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(213, 103, 205, 1),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text('Lihat Gambar'),
                            // onPressed: () {},
                            onPressed: () {
                              Get.toNamed(Routes.SHOW,
                                  arguments: data2['username']);
                            },
                          ),
                          // color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            await controller.getImage(true);
            Get.snackbar("Success", "Berhasil Upload Gambar",
                backgroundColor: Colors.green, colorText: Colors.white);
            // ImagePicker imagePicker = ImagePicker();
            // XFile? file =
            //     await imagePicker.pickImage(source: ImageSource.gallery);

            // if(file==null)return;

            // String uniqueFileName =
            //     DateTime.now().microsecondsSinceEpoch.toString();

            // Reference referenceRoot = FirebaseStorage.instance.ref();
            // Reference referenceDirImage = referenceRoot.child('images');

            // Reference referenceImageToOpload=referenceDirImage.child(uniqueFileName);
            // try{
            //   await referenceImageToOpload.putFile(File(file!.path));
            //   imageUrl =await referenceImageToOpload.getDownloadURL();
            // }catch(error){

            // }
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(213, 103, 205, 1), // background
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text('Upload Foto'),
        ),
      ),
    );

    // return Center(child: CircularProgressIndicator());
  }
}
