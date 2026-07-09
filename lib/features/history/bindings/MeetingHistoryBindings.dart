import 'package:birlacable/features/history/controller/Meeting_HistoryController.dart';
import 'package:birlacable/features/history/services/Meeting_Historyservices.dart';
import 'package:birlacable/features/meeting/controller/Meeting_DashboardController.dart';
import 'package:birlacable/features/meeting/services/Meeting_services.dart';
import 'package:get/get.dart';

class MeetingHistoryBindings extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<Meeting_HistoryController>(() => Meeting_HistoryController());
    Get.lazyPut<Meeting_Historyservices>(
          () => Meeting_Historyservices(),
    );
  }


}