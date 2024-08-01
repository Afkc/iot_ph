import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAOAL9x4jhaILoCNuyikFluO6-7weHPtjI',
              appId: '1:314789748626:android:f90cdfd551814fcc17ab4b',
              messagingSenderId: '314789748626',
              projectId: 'skripsi-iot-219de'))
      : await Firebase.initializeApp();

  Intl.defaultLocale = 'id_ID';
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
