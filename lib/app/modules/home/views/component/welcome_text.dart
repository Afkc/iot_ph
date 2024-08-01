import 'package:flutter/material.dart';
import 'package:get/get.dart';

class welcome extends StatelessWidget {
  const welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang',
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Yuk, kita lihat seberapa\n baik kolam Anda dalam\n setiap aspek!',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
        Expanded(
          child: Image.asset(
            'assets/image/kolam.png',
            width: Get.width * 0.5,
          ),
        ),
      ],
    );
  }
}