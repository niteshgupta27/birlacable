
import 'package:birlacable/Utill/app_required.dart';
import 'package:birlacable/features/meetingDashboard/service/MeetingOptionService.dart';

import 'package:birlacable/features/meetingDashboard/controller/MeetingOptionController.dart';


class MeetingOptionBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MeetingOptionController>(() => MeetingOptionController());
    Get.lazyPut<MeetingOptionService>(() => MeetingOptionService());

  }

}