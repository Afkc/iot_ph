import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  Rx<DateTime> hari = DateTime.now().obs;
  RxString currentTime = "".obs;

  @override
  void onInit() {
    super.onInit();
    displayDate();
    displayDay();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
  }

  String displayDay() {
    return DateFormat('EEEE', 'id_ID').format(DateTime.now());
  }

  String displayDate() {
    return DateFormat('d MMMM y', 'id_ID').format(DateTime.now());
  }

  void _updateTime() {
    currentTime.value = DateFormat('HH:mm:ss').format(DateTime.now());
  }

  @override
  void onReady() {
    super.onReady();

    update();
  }

  void nagivateToNavigation() {
    Get.offAllNamed(Routes.NAVIGATION);
    print('navigating to detail');
  }

  Future exportExel() async {
    if (await Permission.storage.request().isGranted) {
      var excel = Excel.createExcel();
      excel.rename(excel.getDefaultSheet()!, 'Data Tambak Udang');

      var sheet = excel['Data Tambak Udang'];
      var cell1 = sheet.cell(CellIndex.indexByString("A1"));
      cell1.value = TextCellValue('Hari');
      var cell2 =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1));
      cell2.value = TextCellValue('tanggal');

      var directory = await path_provider.getTemporaryDirectory();
      var filePath = '${directory.path}/data.xlsx';
      excel.save(fileName: filePath);

    }

    

    
    // Excel excel = Excel.createExcel();
    // excel.rename(excel.getDefaultSheet()!, 'Data Tambak Udang');

    // var sheet = excel['Data Tambak Udang'];
    // var cell1 = sheet.cell(CellIndex.indexByString("A1"));
    // cell1.value = TextCellValue('Hari');
    // var cell2 =
    //     sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1));
    // cell2.value = TextCellValue('tanggal');

    // var directory = await path_provider.getTemporaryDirectory();
    // var filePath = '${directory.path}/data.xlsx';
    // excel.save(fileName: filePath);

    // return filePath;
  }

  Future createExcel() async {
  var excel = Excel.createExcel();
  var sheet = excel['Data Tambak Udang'];

  var cell1 = sheet.cell(CellIndex.indexByString("A1"));
  cell1.value = TextCellValue('Hari');
  var cell2 = sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1));
  cell2.value = TextCellValue('tanggal');

  var filePath = '${(await getExternalStorageDirectory())!.path}/data.xlsx';
  final file = File(filePath);
  await file.writeAsBytes(excel.encode()!);
  OpenFile.open(filePath);
  print(filePath);
}
}
