import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas10/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: [
              Image.asset(
                'images/flower.png',
              ),
              const Text(
                "HELLO FELLAS.",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Temukan segala jenis bunga dari berbagai belahan dunia!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
        splashIconSize: 500,
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
        nextScreen: const LoginView());
  }
}

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
              child: Image.asset(
                'images/login.png',
                height: 200,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: const Text(
                'Welcome To Azalea',
                style: TextStyle(
                    color: Color.fromRGBO(51, 65, 85, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  // labelText: 'Email',
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
                  child: const Text('Login'),
                  // onPressed: () {},
                  onPressed: () => controller.login(
                      controller.emailController.text,
                      controller.passwordController.text),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Does not have an account?'),
                TextButton(
                  child: Text('Register'),
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
