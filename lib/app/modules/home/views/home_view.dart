

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'component/information_card.dart';
import 'component/welcome_text.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambak Udang Inovasi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(left: 14),
            child: welcome(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: StreamBuilder(
                stream: FirebaseDatabase.instance.ref().child('data').onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No data available');
                  } else {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.displayDay(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      controller.displayDate(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Obx(
                                      () => Text(
                                        controller.currentTime.value,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )),
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Service ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Unduh Laporan',
                                  style: TextStyle(color: Colors.grey),
                                ))
                          ],
                        ),
                        information_card(
                          need: snapshot.data!.snapshot.value['pH'].toString(),
                          title: 'pH Air',
                          icon: Icons.water_drop_outlined,
                          color: Colors.pinkAccent.withOpacity(0.5),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        information_card(
                          need: snapshot.data!.snapshot.value['temperature']
                              .toString(),
                          title: 'Temperature',
                          icon: Icons.dew_point,
                          color: Colors.blueAccent.withOpacity(0.5),
                          
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        information_card(
                          need:
                              '${snapshot.data!.snapshot.value['ketinggian']} m',
                          title: 'Kekeruhan Air',
                          icon: Icons.waves_outlined,
                          color: Colors.orangeAccent.withOpacity(0.8),
                        ),
                        SizedBox(height: 10,),
                        
                        // ElevatedButton(
                        //     onPressed: () {
                        //       controller.createExcel();
                        //     }, child: Text('Export Exel')),
                        SizedBox(
                          height: 100,)
                        
                      ],
                    );
                  }
                }),
          )
        ]),
      ),
      floatingActionButton: SizedBox(
        width: Get.width * 0.3,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.NAVIGATION);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.blueAccent, width: 2)),
          backgroundColor: Colors.blueAccent,
          child: Image(image: AssetImage('assets/image/quit.png')),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
