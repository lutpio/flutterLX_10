import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas10/TokenManager.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  bool tokenAvailable = await TokenManager.getTokenAvailability();
  await ScreenUtil.ensureScreenSize(); // flutter_screenutil
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDspgLlg1c9qj4E_VAIkcYwGSxrcZtEd6I',
    appId: '1:579433355682:android:e40a0de87d42de10a67afb',
    messagingSenderId: '579433355682',
    projectId: 'tugas10-a52a2',
    storageBucket: 'tugas10-a52a2.appspot.com',
  )); // firebase_core
  await GetStorage.init(); // get_storage
  // tz.initializeTimeZones(); // timezone for local notification

  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: tokenAvailable ? Routes.HOME : Routes.LOGIN,
        getPages: AppPages.routes,
        theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  );
}

// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   await ScreenUtil.ensureScreenSize();

//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: 'AIzaSyDspgLlg1c9qj4E_VAIkcYwGSxrcZtEd6I',
//       appId: '1:579433355682:android:e40a0de87d42de10a67afb',
//       messagingSenderId: '579433355682',
//       projectId: 'tugas10-a52a2',
//       storageBucket: 'tugas10-a52a2.appspot.com',
//     ),
//   );
//   await GetStorage.init();

//   bool tokenAvailable = await TokenManager.getTokenAvailability();
//   // String? username = await TokenManager.getToken();
//   // if (username != null) {
//   //   print("Nama pengguna: $username");
//   // } else {
//   //   print("Nama pengguna tidak tersedia");
//   // }
//   runApp(ScreenUtilInit(
//     designSize: const Size(414, 896),
//     builder: (_, __) => GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       initialRoute: tokenAvailable ? Routes.HOME : Routes.LOGIN,
//       getPages: AppPages.routes,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         backgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     ),
//   ));
// }
// class TokenManager {
//   Future<String> generateToken() async {
//     String token = Uuid().v4();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user_token', token);
//     return token;
//   }

//   Future<void> deleteToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user_token'); // Menghapus token
//   }

//   Future<String?> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_token'); // Mengambil token
//   }

//   Future<bool> getTokenAvailability() async {
//     String? token = await getToken();
//     return token != null;
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//     apiKey: 'AIzaSyDspgLlg1c9qj4E_VAIkcYwGSxrcZtEd6I',
//     appId: '1:579433355682:android:e40a0de87d42de10a67afb',
//     messagingSenderId: '579433355682',
//     projectId: 'tugas10-a52a2',
//   ));
//   await GetStorage.init();
//   await ScreenUtil.ensureScreenSize();
//   runApp(ScreenUtilInit(
//     designSize: const Size(414, 896),
//     builder: (_, __) => GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       // initialRoute: AppPages.INITIAL,
//       initialRoute: TokenManager.getTokenAvailability() == true
//           ? Routes.HOME
//           : Routes.LOGIN,
//       getPages: AppPages.routes,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         backgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     ),
//   )); // flutter_screenutil
//   // runApp(MyApp());
// }





// class MyApp extends StatelessWidget {
  
// class MyApp extends StatelessWidget {
//   final authC = Get.put(LoginController(), permanent: true);
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: authC.streamAuthStatus,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             print(snapshot);
//             return GetMaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: "Application",
//               initialRoute:
//                   snapshot.data != null && snapshot.data!.emailVerified == true
//                       ? Routes.HOME
//                       : Routes.LOGIN,
//               getPages: AppPages.routes,
//               theme: ThemeData(
//                 primarySwatch: Colors.indigo,
//               ),
//             );
//           }
//           return LoadingView();
//         });
//   }
// }
