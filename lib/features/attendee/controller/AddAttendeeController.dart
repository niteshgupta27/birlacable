import 'dart:io';

import 'package:intl/intl.dart';

import '../../../Utill/Apputills.dart';
import '../../../Utill/DialogHelper.dart';
import '../../../Utill/ImageHelper.dart';
import '../../../Utill/app_required.dart';
import '../../camera/camera_page.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/AdhesiveModel.dart';
import '../model/RoleModel.dart';
import '../model/Table_Attendee.dart';
import '../service/AttendeeService.dart';

class AddAttendeeController extends GetxController {
  String TAG = "AddAttendeeController";
  var productServices = Get.find<AttendeeService>();
  RxBool isLoading = false.obs;
  var appStorage = Get.find<AppStorage>();
  RxString appName = "".obs;
  Rx<TextEditingController> Painter_NameController =
      TextEditingController().obs;
  Rx<TextEditingController> Phone_NumberController =
      TextEditingController().obs;
  Rx<TextEditingController> Pan_CardController = TextEditingController().obs;
  Rx<TextEditingController> ShopnameController = TextEditingController().obs;
  Rx<TextEditingController> ShopLocationController =
      TextEditingController().obs;

  Rx<TextEditingController> shopCodeController = TextEditingController().obs;

  RxString selectedTeamSize = "".obs;
  List<String> teamSizeOptions = ["1–5", "6–10", "11–20", "20+"];

  RxString selectedSitePerMonth = "".obs;
  List<String> sitePerMonthOptions = ["1–5", "6–10", "11–20", "20+"];

  RxString selectedExperience = "".obs;
  List<String> experienceOptions = ["0–2 years", "3–5 years", "6–10 years", "10+ years"];

  RxString selectedQualification = "".obs;
  List<String> qualificationOptions = [
    "No School",
    "Up to 5th",
    "Up to 8th",
    "10th Pass",
    "12th Pass",
    "ITI Diploma",
    "Diploma",
    "Graduate",
    "Post Graduate"
  ];

  RxString selectedProjectType = "".obs;
  List<String> projectTypeOptions = ["Residential", "Commercial", "Industrial"];

  RxList<String> selectedAdhesives = <String>[].obs;

  RxString decisionMaker = "Self".obs;
  List<String> decisionMakerOptions = ["Self", "Customer"];

  RxString selectedPurchaseFrequency = "".obs;
  List<String> purchaseFrequencyOptions = [
    "Weekly",
    "Monthly",
    "As per project requirement"
  ];

  RxString selectedPurchaseSource = "".obs;
  List<String> purchaseSourceOptions = [
    "Electrical Retailer",
    "Distributor/Wholesaler",
    "Company Dealer"
  ];

  Rx<TextEditingController> DealerCodeController = TextEditingController().obs;

  Rx<TextEditingController>  teamSizeController = TextEditingController().obs;
  // Rx<TextEditingController>  orderDeailController = TextEditingController().obs;
  Rx<TextEditingController>  GiftGivenController = TextEditingController().obs;
  Rx<TextEditingController> remark1Controller = TextEditingController().obs;
  Rx<TextEditingController> remark2Controller = TextEditingController().obs;
  Rx<TextEditingController> remark3Controller = TextEditingController().obs;
  Rx<TextEditingController> companynameController = TextEditingController().obs;
  RxList<AdhesiveModel> Adhesive=<AdhesiveModel>[].obs;

  //RxString dealer_dropdown = "".obs;
  RxString fld_p_image_path = "".obs;

  Rx<TableMeetingsModel> meeting = TableMeetingsModel.fromJson({}).obs;
  List<String> radiooptions = ["Yes", "No"];
  RxString CRMRegistered="No".obs;

  RxString smartphoneOption="No".obs;
  RxString participantOption = "Yes".obs;
  RxString attendeeType = "Electrician".obs;
  List<String> attendeeTypeOptions = ["Electrician", "Contractor"];
  RxString Enrolled_Loyalty = "No".obs;

  RxString DownloadApp="Yes".obs;
  // RxString PolisherApp="Yes".obs;
  // RxString Contractoroption="No".obs;
  RxString isgiftgiven="No".obs;
  // Table_Attendee attendee=Table_Attendee
  //     .fromJson({});
  Rx<Dealer> selectedDealer = Dealer.fromJson({}).obs;
  RxList<Dealer> dealers = <Dealer>[].obs;
  int Attendee_id = 0;
  String fld_attendance = "0";
  RxList<RoleModel> rolluser = <RoleModel>[].obs;
  Rx<RoleModel> selectedRoll = RoleModel.fromJson({}).obs;
  Rx<TextEditingController>  DobController = TextEditingController().obs;
  Rx<TextEditingController>  AgeController = TextEditingController().obs;
  Rx<TextEditingController>  fatherNameController = TextEditingController().obs;
  Rx<TextEditingController>  QualificationController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> pincodeController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if (arguments != null) {
      meeting.value = TableMeetingsModel.fromJson(arguments['data']);
      dealers.value = meeting.value.dealers;
      //debugPrint(arguments['Attendees']);
      if (arguments['Attendees'] != null) {
        Table_Attendee data = arguments['Attendees'];
        Phone_NumberController.value.text = data.fldMobile;
        Painter_NameController.value.text = data.fldAttendeeName;
        Pan_CardController.value.text = data.fldPancard;
        //  QualificationController.value.text = data.fldQualification;
        //  ReasonController.value.text = data.fldNotDownloadReason;
        //  teamSizeController.value.text = data.fldContractorTeamSize;
        //  sitesController.value.text = data.fldContractorSites;
        // // DealerCodeController.value.text = data.fld;
        //  orderValueController.value.text = data.fldOrderPlaced;
        //  orderDeailController.value.text = data.fldOrderDetails;
        //   GiftGivenController.value.text = data.fldGiftGiven;
        remark1Controller.value.text = data.fldRemark1;
        remark2Controller.value.text = data.fldRemark2;
        remark3Controller.value.text = data.fldRemark3;
        addressController.value.text = data.fldAddress;
        cityController.value.text = data.fldCity;
        pincodeController.value.text = data.fldPincode;
        // smartphoneOption.value=data.fldSmartphone=="1"?"Yes":"No";
        //  DownloadApp.value=data.fldAppDownloadNebula=="1"?"Yes":"No";
        //  PolisherApp.value=data.fldAppDownloadAttendee=="1"?"Yes":"No";
        //  Contractoroption.value=data.fldContractor=="1"?"Yes":"No";
        //  orderoption.value=data.fldOrderPlaced=="1"?"Yes":"No";
        Attendee_id = data.fldAid;
        fld_attendance = data.fldAttendance.toString();
        print("jjjjjjjjjjj${meeting.value.toJson()}");
        print("jjjjjjjjjjj${data.fldDealerId}");
        if (data.fldDealerId != "" && dealers.any((dealer) => dealer.fldDrid == int.tryParse(data.fldDealerId))) {
          selectedDealer.value = dealers.firstWhere(
                (dealer) => dealer.fldDrid == int.parse(data.fldDealerId),
          );
          DealerCodeController.value.text = selectedDealer.value.fldRcode ?? "";
        } else if (dealers.isNotEmpty) {
          selectedDealer.value = dealers.first;
          DealerCodeController.value.text = selectedDealer.value.fldRcode ?? "";
        }
        //CallGetdata();
      } else if (dealers.isNotEmpty) {
        selectedDealer.value = dealers.first;
        DealerCodeController.value.text = selectedDealer.value.fldRcode ?? "";
      }
    }
    CallGetdata();
  }

  Future<void> takePhoto(String imagetype, BuildContext context) async {
    if (Painter_NameController.value.text.toString().isNotEmpty) {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CameraPage(needSelfyMode: false);
          },
        ),
      );

      // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (result["result"] != null) {
        try {
          File file = File(result["result"]);
          // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

          // File file = File(photo.path);
          File processedFile = await ImageHelper.processImage(
            file,
            meeting.value,
            Painter_NameController.value.text,
          );
          if (imagetype == "p") {
            fld_p_image_path.value = processedFile.path;
          }
        } catch (e) {
          AppUtils.showSnackbar(Get.context!,e.toString(), "Info");
          print(
            "Error during image selection: $e",
          ); //Proper logging for debugging and reporting
          // Handle errors appropriately, e.g., display an error message to the user.
        }
      }
    } else {
      AppUtils.showSnackbar(Get.context!,"Please enter your name", "Info");
    }
  }

  validateAndProcess() async {
    String regex = r'^[6-9]\d{9}$';

    if (Painter_NameController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar(Get.context!,"Please enter your name", "Info");
    } else if (Phone_NumberController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar(Get.context!,"Please enter mobile number", "Info");
    } else if (!RegExp(regex).hasMatch(Phone_NumberController.value.text)) {
      AppUtils.showSnackbar(Get.context!,"Please enter valid mobile number", "Info");
    }
    // else if ( Enrolled_Loyalty=="Yes"&&companynameController.value.text.trim().isEmpty) {
    //   AppUtils.showSnackbar(Get.context!,"Please enter Company name", "Info");
    // }
    // else if ( attendeeType =="Electrician"&&ShopLocationController.value.text.trim().isEmpty) {
    //   AppUtils.showSnackbar(Get.context!,"Please enter shop location", "Info");
    // }
    // else if (smartphoneOption == "Yes" && DownloadApp == "No" && PolisherApp == "No" && ReasonController.value.text.isEmpty) {
    //   AppUtils.showSnackbar("Please enter Reason", "Info");
    // } else if (participantOption == "Yes" && orderoption == "Yes" && orderValueController.value.text.isEmpty && orderDeailController.value.text.isEmpty) {
    //   AppUtils.showSnackbar("Please enter valid order details", "Info");
    // }
    else if (isgiftgiven=="Yes" && GiftGivenController.value.text.isEmpty) {
      AppUtils.showSnackbar(Get.context!,"Please enter gift Given", "Info");
    }
    else if ( attendeeType !="Electrician" && selectedTeamSize.value.isEmpty) {
      AppUtils.showSnackbar(Get.context!,"Please select Team Size", "Info");
    } else if (attendeeType !="Electrician" && selectedSitePerMonth.value.isEmpty) {
      AppUtils.showSnackbar(Get.context!,"Please select number of Site", "Info");
    } 
    else if (AgeController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar(Get.context!, "Please select Date of Birth", "Info");
    } else if ((int.tryParse(AgeController.value.text) ?? 0) < 17) {
      AppUtils.showSnackbar(Get.context!, "Minimum age should be 17 years", "Info");
    }
    else if (fatherNameController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar(Get.context!, "Please enter father name", "Info");
    }
    // else if (selectedExperience.value.isEmpty) {
    //   AppUtils.showSnackbar(Get.context!,"Please select Years of Experience", "Info");
    // } else if (selectedQualification.value.isEmpty) {
    //   AppUtils.showSnackbar(Get.context!, "Please select Qualification", "Info");
    // } else if (addressController.value.text.trim().isEmpty) {
    //   AppUtils.showSnackbar(Get.context!, "Please enter address", "Info");
    // }
    else if (cityController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar(Get.context!, "Please enter city", "Info");
    }
    // else if (pincodeController.value.text.trim().isEmpty) {
    //   AppUtils.showSnackbar(Get.context!, "Please enter pincode", "Info");
    // } else if (pincodeController.value.text.trim().length != 6) {
    //   AppUtils.showSnackbar(Get.context!, "Please enter valid 6-digit pincode", "Info");
    // } else if (selectedProjectType.value.isEmpty) {
    //   AppUtils.showSnackbar(
    //       Get.context!, "Please select Primary Project Type", "Info");
    // } else if (selectedAdhesives.isEmpty) {
    //   AppUtils.showSnackbar(
    //       Get.context!, "Please select at least one Preferred Brand", "Info");
    // } else if (
    //     selectedPurchaseFrequency.value.isEmpty) {
    //   AppUtils.showSnackbar(
    //       Get.context!, "Please select Purchase Frequency", "Info");
    // } else if (
    //     selectedPurchaseSource.value.isEmpty) {
    //   AppUtils.showSnackbar(
    //       Get.context!, "Please select Purchase Source", "Info");
    // }
    else if (selectedDealer.value.fldDrid == 0) {
      AppUtils.showSnackbar(Get.context!,"Please select dealer name", "Info");
    } else {
      if (await AppUtils.checkInternetConnectivity()) {
        // Get.offNamed(Routes.HOMESCREEN);
        CallNoteAdd_update();
      } else {
        AppUtils.showSnackbar(Get.context!,"Please check Internet Connection", "Info");
      }
    }
  }

  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value = true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'fld_meeting_id': meeting.value.fldMId,
      'fld_customer_id': meeting.value.fldCustomerId,
      'fld_dealer_id': selectedDealer.value.fldDrid,
      "fld_attendee_name": Painter_NameController.value.text,
      "fld_pancard": Pan_CardController.value.text,
      "fld_mobile": Phone_NumberController.value.text,
      "fld_dob": DobController.value.text.toString(),
      "fld_age": AgeController.value.text,
      "fld_father_name": fatherNameController.value.text,
      "fld_qualification": selectedQualification.value,
      //QualificationController.value.text,
      "fld_gift_given":isgiftgiven=="Yes"?GiftGivenController.value.text:"" ,
      // GiftGivenController.value.text,
      "fld_contractor": attendeeType=="Electrician"?0:1,
      //participantOption.value=="Yes"&& Contractoroption.value=="Yes"?1:0,
      "fld_contractor_team_size": attendeeType!="Electrician"?selectedTeamSize.value:"",
      "fld_contractor_sites": attendeeType!="Electrician"?selectedSitePerMonth.value:"",
      //participantOption.value=="Yes"&& Contractoroption.value=="Yes"?sitesController.value.text:"",
      "fld_smartphone": smartphoneOption=="Yes"?1:0,
      "fld_app_download_nebula":smartphoneOption=="Yes" && DownloadApp.value=="Yes"?1:0,
      "fld_app_download_attendee": 0,
      //participantOption.value=="Yes"&&smartphoneOption.value=="Yes" && Contractoroption.value=="Yes"&& DownloadApp.value=="No"&& PolisherApp.value=="Yes"?1:0,
      "fld_not_download_reason": "",
      //participantOption.value=="Yes"&&smartphoneOption.value=="Yes" && Contractoroption.value=="Yes"&& DownloadApp.value=="No"&& PolisherApp.value=="No"?ReasonController.value.text:"",
      "fld_adhesive_consumption": "",
      "fld_attendance": Attendee_id != 0 ? "1" : fld_attendance,
      "fld_participant": participantOption.value == "Yes" ? 1 : 0,
      "fld_adhesive_brand": "",
      "fld_order_value": "",
      //participantOption.value=="Yes"&& orderoption.value=="Yes"?orderValueController.value.text:"",
      "fld_order_details": "",
      //participantOption.value=="Yes"&& orderoption.value=="Yes"?orderDeailController.value.text:"",
      "fld_order_placed": 0,
      //participantOption.value=="Yes"&& orderoption.value=="Yes"?1:0,
      "fld_ref_1": "",
      "fld_ref_2": "",
      "fld_ref_3": "",
      // "fld_ref_4": "",
      // "fld_ref_5": "",
      "fld_remark_1": remark1Controller.value.text,
      "fld_remark_2": remark2Controller.value.text,
      "fld_remark_3": remark3Controller.value.text,
      "fld_competition_points": "",
      "image": fld_p_image_path.isNotEmpty
          ? await AppUtils.editImage(fld_p_image_path.value)
          : "",
      "fld_lat": appStorage.lat.value,
      "fld_long": appStorage.long.value,
      "fld_shop_location":"",
      "fld_shop_name": "",
      "fld_shop_code": "",
      "fld_experience":  selectedExperience.value ,
"fld_project_type":selectedProjectType.value,
      "fld_brand_decision":decisionMaker.value,
      "fld_brand_preffered":selectedAdhesives.join(","),
      "fld_purchase_frequency":selectedPurchaseFrequency.value,
      "fld_purchase_source":selectedPurchaseSource.value,
      "fld_royalty_program":Enrolled_Loyalty=="Yes" ?companynameController.value.text:"",
      "fld_address": addressController.value.text,
      "fld_city": cityController.value.text,
      "fld_pincode": pincodeController.value.text,
      "fld_crm":CRMRegistered.value == "Yes" ? 1 : 0,
      if (Attendee_id != 0) 'attendee_id': Attendee_id,
      "fld_staff_id": participantOption.value == "No"
          ? selectedRoll.value.fldSid
          : 0,
    };

    print(requestBody);
    productServices.Addattendee(body: requestBody, modify: Attendee_id != 0)
        .then((value) async {
      isLoading.value = false;
      if (value.success == true) {
        Get.back(result: {"status": "success"});
        AppUtils.showSnackbar(Get.context!,value.message.toString(), "success");
      } else {
        AppUtils.showSnackbar(Get.context!,value.message.toString(), "Error");
      }
    })
        .catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(Get.context!,err.toString(), "server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }

  void getstaffvalue() {
    // AppUtils.alertWithProgressBar();
    isLoading.value = true;

    productServices
        .getstaff()
        .then((value) async {
      isLoading.value = false;
      if (value.success == true && value.data.isNotEmpty) {
        rolluser.value = value.data;
        selectedRoll.value = rolluser.first;
      } else {
        // Get.back();

        AppUtils.showSnackbar(Get.context!,value.message.toString(), "Info");
      }
    })
        .catchError((err) {
      // Get.back();
      isLoading.value = false;
      AppUtils.showSnackbar(Get.context!,"Something went wrong", "Oops");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }

  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      getstaffvalue();
     // Calladhesives();
    } else {
      AppUtils.showSnackbar(Get.context!,"Please check Internet Connection", "Info");
    }
  }

  void deleteNoteAt(String Imagetype) {
    DialogHelper.showDeleteDialog(
      title: "Are you sure you want to delete?",
      content: "This action cannot be undone.",
      onConfirm: () {
        if (Imagetype == "p") {
          fld_p_image_path.value = "";
        }
      },
    );
  }
  Future<void> Calladhesives() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;

    productServices.getadhesives(fld_uid:appStorage.loggedInUser.id).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        Adhesive.value=value.data;
      }else{
        AppUtils.showSnackbar(Get.context!,value.message.toString(),"Error");
      }
    }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(Get.context!,err.toString(),"server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
  void calculateAge(String dob) {
    try {
      final date = DateFormat('yyyy/MM/DD').parse(dob);
      var age = DateTime.now().year - date.year;
      if (DateTime.now().month < date.month || (DateTime.now().month == date.month && DateTime.now().day < date.day)) {
        age--;
      }
      AgeController.value.text = age.toString();
    } catch (e) {
      print('Invalid date format');
    }
  }
}
