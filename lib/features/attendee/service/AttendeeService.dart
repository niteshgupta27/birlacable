import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../model/AdhesiveResponse.dart';
import '../model/AttendeeListresponseModel.dart';
import '../model/QuestionModel.dart';
import '../model/RoleModel.dart';

class AttendeeService {
  String TAG = "AttendeeService";

  Future<AttendeeListresponseModel> gethomedata({body, modify}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.attendee_LIST, body: body);
      print("response=====$response");
      return AttendeeListresponseModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

  Future<GenralResponceModel> Addattendee({body, required bool modify}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
        endPoint: modify ? AppConstants.UPdate_MEETING_ATTENDEE : AppConstants.UPLOAD_MEETING_ATTENDEE,
        body: body,
      );
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

  Future<AdhesiveResponse> getadhesives({fld_uid}) async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.GET_adhesives}?user_id=$fld_uid",
      );
      print("response=====$response");
      return AdhesiveResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

  Future<GenralResponceModel> getmisscall({cureentDate}) async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.AttendeeRefresh}$cureentDate",
      );
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

  Future<RoleModelResponse> getstaff() async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.getstaff}",
      );
      print("response=====$response");
      return RoleModelResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

  Future<QuestionResponse> getSurveyQuestions({required String user_id, required String meeting_id, required String attendee_id}) async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.SURVEY_QUESTIONS}?user_id=$user_id&meeting_id=$meeting_id&attendee_id=$attendee_id",
      );
      return QuestionResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      rethrow;
    }
  }

  Future<GenralResponceModel> submitSurvey({required Map<String, dynamic> body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
        endPoint: AppConstants.SUBMIT_SURVEY,
        body: body,
      );
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      rethrow;
    }
  }
}
