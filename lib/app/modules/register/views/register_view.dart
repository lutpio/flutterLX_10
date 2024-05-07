import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas10/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: const Text(
                'Register Your Account',
                style: TextStyle(
                    color: Color.fromRGBO(51, 65, 85, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Address',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                obscureText: true,
                controller: controller.passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                obscureText: true,
                controller: controller.passwordController2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(213, 103, 205, 1),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Register'),
                    onPressed: () async {
                      if (controller.usernameController.text.isEmpty ||
                          controller.nameController.text.isEmpty ||
                          controller.phoneController.text.isEmpty ||
                          controller.addressController.text.isEmpty ||
                          controller.passwordController.text.isEmpty ||
                          controller.passwordController2.text.isEmpty) {
                        Get.snackbar('Error', 'Lengkapi data terlebih dahulu',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            snackStyle: SnackStyle.FLOATING);
                      } else if (controller.passwordController.text !=
                          controller.passwordController2.text) {
                        Get.snackbar('Error', 'Password tidak valid',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            snackStyle: SnackStyle.FLOATING);
                      } else {
                        final usernameExist = await controller.isUsernameExists(
                            controller.usernameController.text);
                        if (usernameExist) {
                          Get.snackbar('Error', 'Username sudah dipakai',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              borderRadius: 10,
                              margin: const EdgeInsets.all(10),
                              snackStyle: SnackStyle.FLOATING);
                        } else {
                          await controller.saveUser(
                              controller.usernameController.text,
                              controller.nameController.text,
                              controller.addressController.text,
                              controller.phoneController.text,
                              controller.passwordController.text);
                          Get.back();
                          Get.snackbar("Berhasil", "Berhasil Register",
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                          Get.offAllNamed(Routes.LOGIN);
                        }
                      }
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  child: Text('Login'),
                  onPressed: () => Get.back(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
