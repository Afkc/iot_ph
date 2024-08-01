import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ph_controller.dart';

class PhView extends GetView<PhController> {
  const PhView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PhView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
