import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tugas10/UserImage.dart';

import '../controllers/show_controller.dart';

class ShowView extends GetView<ShowController> {
  const ShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 242, 255, 1),
        title: const Text('Gambar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<UserImage>>(
            stream: controller.readImage(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (snapshot.hasData) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                          topRight: Radius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data?[index].images ?? "",
                          height: 100,
                          width: 200,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     ClipRRect(
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(
                      //           ScreenUtil().setWidth(10),
                      //         ),
                      //         topRight: Radius.circular(
                      //           ScreenUtil().setWidth(10),
                      //         ),
                      //       ),
                      //       child: CachedNetworkImage(
                      //         imageUrl: snapshot.data?[index].images ?? "",
                      //         height: 100,
                      //         width: 200,
                      //         fit: BoxFit.cover,
                      //         errorWidget: (context, url, error) =>
                      //             const Icon(Icons.error),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                  itemCount: snapshot.data?.length,
                );
              } else {
                return const Center(
                  child: Text("Data Kosong"),
                );
              }
            }),
      ),
    );
  }
}
