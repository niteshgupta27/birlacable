import '../../../Utill/Apputills.dart';
import '../../../Utill/app_required.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/Table_Attendee.dart';
import '../service/AttendeeService.dart';
import '../model/QuestionModel.dart';

class QuestionController extends GetxController {
  String TAG = "QuestionController";
  var productServices = Get.find<AttendeeService>();
  RxBool isLoading = false.obs;
  var appStorage = Get.find<AppStorage>();

  Rx<TableMeetingsModel> meeting = TableMeetingsModel.fromJson({}).obs;
  Rx<Table_Attendee> attendee = Table_Attendee.fromJson({}).obs;
  
  RxList<QuestionData> questions = <QuestionData>[].obs;
  RxBool isSubmitted = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      meeting.value = TableMeetingsModel.fromJson(arguments['data']);
      if (arguments['Attendees'] != null) {
        attendee.value = arguments['Attendees'];
        fetchQuestions();
      }
    }
  }

  Future<void> fetchQuestions() async {
    isLoading.value = true;
    try {
      final response = await productServices.getSurveyQuestions(
        user_id: appStorage.loggedInUser.id.toString(),
        meeting_id: meeting.value.fldMId.toString(),
        attendee_id: attendee.value.fldAid.toString(),
      );
      if (response.status) {
        questions.assignAll(response.data);
        isSubmitted.value = response.isSubmitted;
      } else {
        AppUtils.showSnackbar(Get.context!, "Failed to fetch questions", "Error");
      }
    } catch (e) {
      AppUtils.showSnackbar(Get.context!, "Something went wrong", "Error");
    } finally {
      isLoading.value = false;
    }
  }

  void onOptionSelected(int questionIndex, String option) {
    if (!isSubmitted.value) {
      questions[questionIndex].selectedOption = option;
      questions.refresh();
    }
  }

  Future<void> submitSurvey() async {
    // Validate that all questions have a selected option
    if (questions.any((q) => q.selectedOption == null)) {
      AppUtils.showSnackbar(Get.context!, "Please answer all questions", "Info");
      return;
    }

    isLoading.value = true;
    try {
      var surveyData = questions.map((q) => {
        "question_id": q.id,
        "answer": q.selectedOption,
      }).toList();

      var requestBody = {
        "user_id": attendee.value.fldAid,
        "attendee_id": attendee.value.fldAid,
        "meeting_id": meeting.value.fldMId,
        "answers": surveyData,
      };

      final response = await productServices.submitSurvey(body: requestBody);
      if (response.success == true) {

        Get.back(result: {"status": "success"});
        AppUtils.showSnackbar(Get.context!, response.message.toString(), "Success");
      } else {
        AppUtils.showSnackbar(Get.context!, response.message.toString(), "Error");
      }
    } catch (e) {
      AppUtils.showSnackbar(Get.context!, "Submission failed", "Error");
    } finally {
      isLoading.value = false;
    }
  }
}
