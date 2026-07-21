import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../controller/AddAttendeeController.dart';
import '../model/RoleModel.dart';

class AddAttendeeView extends GetView<AddAttendeeController> {
  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // controller.onInit();
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColors.whites,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
              onPressed: () => Get.back(),
            ),
            title: Text(
              "Attendee Details ${controller.appStorage.loggedInUser.username}",
              style: Styles.headerTitel,
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: AppColors.gray.withOpacity(0.5),
            surfaceTintColor: Colors.transparent,
          ),
          body: SafeArea(
            child: controller.isLoading == true
                ? CustomLoaderWidget(color: AppColors.primaryColor)
                : SingleChildScrollView(
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.manual,

              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        controller.meeting.value.fldLocation!,
                        style: Styles.headerTitel,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.Painter_NameController.value,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteTitle.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.Phone_NumberController.value,
                      maxLength: 10,
                      // Limit to 10 digits
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.fatherNameController.value,
                      decoration: InputDecoration(labelText: 'Father Name',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: controller.cityController.value,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteTitle.value = value,
                    ),
                    const SizedBox(height: 16),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 5, right: 5),
                    //   child: Text("Certification Details", style: Styles.PageTitle.copyWith(color: AppColors.primaryColor)),
                    // ),
                    // const SizedBox(height: 16),
                    TextFormField(controller: controller.DobController.value,keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(labelText: 'Dob',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null; // Optional field, so it's valid if empty
                        }
                        try {
                          final date = DateFormat('dd/MM/yyyy').parse(value);
                          if (date.isAfter(DateTime.now())) {
                            return 'Date of birth cannot be in the future';
                          }
                          // Calculate age
                          var age = DateTime.now().year - date.year;
                          if (DateTime.now().month < date.month || (DateTime.now().month == date.month && DateTime.now().day < date.day)) {
                            age--;
                          }
                          // Set age in the ageController
                          // controller.AgeController.value.text = age.toString();
                        } catch (e) {
                          return 'Invalid date format. Please use DD/MM/yyyy';
                        }
                        return null;
                      },
                      onChanged: (value) => controller.calculateAge(value) ,
                    ),
                    Text(
                      "yyyy/MM/DD E.g.1987/09/27",
                      style:  TextStyle(
                          fontFamily: AppConstants.fontFamily,
                          fontWeight: FontWeight.w200,
                          color: AppColors.fountGray,
                          fontSize: Dimensions.fontSizeExtraSmall
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.AgeController.value,readOnly: true,
                      decoration: InputDecoration(labelText: 'Age',
                        suffixText: "Years",
                        suffixStyle: const TextStyle(color: AppColors.fountGray),
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),

                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "CRM Registered ?",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 5),
                    Row(
                      children: controller.radiooptions.map((tag) {
                        return Expanded(
                          child: RadioListTile<String>(
                            title: Text(tag),
                            value: tag,activeColor: AppColors.primaryColor,
                            groupValue: controller.CRMRegistered.value,
                            onChanged: (String? value) {
                              controller.CRMRegistered.value = value!;
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("Attendee Type", style: Styles.headerTitel),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: controller.attendeeTypeOptions.map((tag) {
                        return Expanded(
                          child: RadioListTile<String>(
                            title: Text(tag),
                            value: tag,activeColor: AppColors.primaryColor,
                            groupValue: controller.attendeeType.value,
                            onChanged: (String? value) {
                              controller.attendeeType.value = value!;

                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }).toList(),
                    ),
                    // if(controller.attendeeType.value=="Electrician")
                    //   Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    //     const SizedBox(height: 16),
                    //     TextField(
                    //       controller: controller.ShopnameController.value,
                    //       decoration: InputDecoration(
                    //         labelText: 'Shop Name',
                    //         labelStyle: const TextStyle(
                    //           color: AppColors.fountGray,
                    //         ),
                    //         // Change label color
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Default border
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Unfocused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //             width: 2.0,
                    //           ),
                    //           // Focused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //       ),
                    //       // onChanged: (value) => controller.noteTitle.value = value,
                    //     ),
                    //     const SizedBox(height: 16),
                    //     TextField(
                    //       controller: controller.ShopLocationController.value,
                    //       keyboardType: TextInputType.emailAddress,
                    //       decoration: InputDecoration(
                    //         labelText: 'Shop Location',
                    //         labelStyle: const TextStyle(
                    //           color: AppColors.fountGray,
                    //         ),
                    //         // Change label color
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Default border
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Unfocused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //             width: 2.0,
                    //           ),
                    //           // Focused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //       ),
                    //       // onChanged: (value) => controller.noteDescription.value = value,
                    //     ),
                    //     const SizedBox(height: 16),
                    //     TextField(
                    //       controller: controller.shopCodeController.value,
                    //       decoration: InputDecoration(
                    //         labelText: 'Shop Code (Optional)',
                    //         labelStyle: const TextStyle(
                    //           color: AppColors.fountGray,
                    //         ),
                    //         // Change label color
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Default border
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //           ), // Unfocused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColors.fountGray.withOpacity(0.4),
                    //             width: 2.0,
                    //           ),
                    //           // Focused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //       ),
                    //       // onChanged: (value) => controller.noteTitle.value = value,
                    //     ),]),
                    if(controller.attendeeType.value!="Electrician")
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: controller.selectedTeamSize.value.isEmpty
                              ? null
                              : controller.selectedTeamSize.value,
                          decoration: InputDecoration(
                            labelText: 'Team Size',
                            labelStyle:
                                const TextStyle(color: AppColors.fountGray),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          items: controller.teamSizeOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.selectedTeamSize.value = newValue!;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: controller.selectedSitePerMonth.value.isEmpty
                              ? null
                              : controller.selectedSitePerMonth.value,
                          decoration: InputDecoration(
                            labelText: 'Site per Month',
                            labelStyle:
                                const TextStyle(color: AppColors.fountGray),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          items: controller.sitePerMonthOptions
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.selectedSitePerMonth.value = newValue!;
                          },
                        ),

                      ]),

                    const SizedBox(height: 16),
                    // DropdownButtonFormField<String>(
                    //   value: controller.selectedExperience.value.isEmpty
                    //       ? null
                    //       : controller.selectedExperience.value,
                    //   decoration: InputDecoration(
                    //     labelText: 'Years of Experience',
                    //     labelStyle:
                    //     const TextStyle(color: AppColors.fountGray),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4),
                    //           width: 2.0),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   items: controller.experienceOptions
                    //       .map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     controller.selectedExperience.value = newValue!;
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   child: Text(
                    //     "Primary Project Type",
                    //     style: Styles.headerTitel,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // Obx(() => Wrap(
                    //       spacing: 8,
                    //       children: controller.projectTypeOptions.map((type) {
                    //         final isSelected =
                    //             controller.selectedProjectType.value == type;
                    //         return FilterChip(
                    //           label: Text(type),
                    //           selected: isSelected,
                    //           onSelected: (bool value) {
                    //             if (value) {
                    //               controller.selectedProjectType.value = type;
                    //             } else {
                    //               controller.selectedProjectType.value = "";
                    //             }
                    //           },
                    //           selectedColor:
                    //               AppColors.primaryColor.withOpacity(0.2),
                    //           checkmarkColor: AppColors.primaryColor,
                    //           labelStyle: TextStyle(
                    //             color: isSelected
                    //                 ? AppColors.primaryColor
                    //                 : AppColors.fountGray,
                    //             fontWeight: isSelected
                    //                 ? FontWeight.bold
                    //                 : FontWeight.normal,
                    //           ),
                    //           backgroundColor: AppColors.whites,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //             side: BorderSide(
                    //               color: isSelected
                    //                   ? AppColors.primaryColor
                    //                   : AppColors.fountGray.withOpacity(0.4),
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     )),
                    //
                    // const SizedBox(height: 16),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   child: Text("Brand Decision Maker?", style: Styles.headerTitel),
                    // ),
                    // Row(
                    //   children: controller.decisionMakerOptions.map((tag) {
                    //     return Expanded(
                    //       child: RadioListTile<String>(
                    //         title: Text(tag),
                    //         value: tag,
                    //         groupValue: controller.decisionMaker.value,
                    //         activeColor: AppColors.primaryColor,
                    //         onChanged: (String? value) {
                    //           controller.decisionMaker.value = value!;
                    //         },
                    //         contentPadding: EdgeInsets.zero,
                    //         visualDensity: VisualDensity.compact,
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    // const SizedBox(height: 16),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   child: Text("Preferred Brands", style: Styles.headerTitel),
                    // ),
                    // const SizedBox(height: 8),
                    // Obx(() => Wrap(
                    //       spacing: 8,
                    //       children: controller.Adhesive.map((brand) {
                    //         final isSelected = controller.selectedAdhesives
                    //             .contains(brand.fldAdhesiveName);
                    //         return FilterChip(
                    //           label: Text(brand.fldAdhesiveName ?? ""),
                    //           selected: isSelected,
                    //           onSelected: (bool value) {
                    //             if (value) {
                    //               controller.selectedAdhesives
                    //                   .add(brand.fldAdhesiveName!);
                    //             } else {
                    //               controller.selectedAdhesives
                    //                   .remove(brand.fldAdhesiveName);
                    //             }
                    //           },
                    //           selectedColor:
                    //               AppColors.primaryColor.withOpacity(0.2),
                    //           checkmarkColor: AppColors.primaryColor,
                    //           labelStyle: TextStyle(
                    //             color: isSelected
                    //                 ? AppColors.primaryColor
                    //                 : AppColors.fountGray,
                    //             fontWeight: isSelected
                    //                 ? FontWeight.bold
                    //                 : FontWeight.normal,
                    //           ),
                    //           backgroundColor: AppColors.whites,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //             side: BorderSide(
                    //               color: isSelected
                    //                   ? AppColors.primaryColor
                    //                   : AppColors.fountGray.withOpacity(0.4),
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     )),
                    // const SizedBox(height: 16),
                    // DropdownButtonFormField<String>(
                    //   value: controller.selectedPurchaseFrequency.value.isEmpty
                    //       ? null
                    //       : controller.selectedPurchaseFrequency.value,
                    //   decoration: InputDecoration(
                    //     labelText: 'Purchase Frequency?',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4),
                    //           width: 2.0),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   items: controller.purchaseFrequencyOptions
                    //       .map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     controller.selectedPurchaseFrequency.value = newValue!;
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // DropdownButtonFormField<String>(
                    //   value: controller.selectedPurchaseSource.value.isEmpty
                    //       ? null
                    //       : controller.selectedPurchaseSource.value,
                    //   decoration: InputDecoration(
                    //     labelText: 'Purchase Source?',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4),
                    //           width: 2.0),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   items:
                    //       controller.purchaseSourceOptions.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     controller.selectedPurchaseSource.value = newValue!;
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    //   Padding(padding: EdgeInsets.all(5),child:  Text(
                    //     "Enrolled in Loyalty Program?",
                    //     style:  Styles.headerTitel,
                    //   ),),
                    //   const SizedBox(height: 5),
                    //   Row(
                    //     children: controller.radiooptions.map((tag) {
                    //       return Expanded(
                    //         child: RadioListTile<String>(
                    //           title: Text(tag),
                    //           value: tag,activeColor: AppColors.primaryColor,
                    //           groupValue: controller.Enrolled_Loyalty.value,
                    //           onChanged: (String? value) {
                    //             controller.Enrolled_Loyalty.value = value!;
                    //           },
                    //           contentPadding: EdgeInsets.zero,
                    //           visualDensity: VisualDensity.compact,
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),]),
                    // if(controller.Enrolled_Loyalty.value=="Yes")
                    //   Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    //
                    //
                    //     const SizedBox(height: 16),
                    //     TextField(controller: controller.companynameController.value,
                    //       decoration: InputDecoration(labelText: 'please mention the company name',
                    //         labelStyle: const TextStyle(color: AppColors.fountGray),
                    //         // Change label color
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),),
                    //       // onChanged: (value) => controller.noteDescription.value = value,
                    //     )
                    //     ,]),
                    // const SizedBox(height: 16),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Padding(padding: EdgeInsets.all(5),child:  Text(
                        "Gift Given?",
                        style:  Styles.headerTitel,
                      ),),
                      const SizedBox(height: 5),
                      Row(
                        children: controller.radiooptions.map((tag) {
                          return Expanded(
                            child: RadioListTile<String>(
                              title: Text(tag),
                              value: tag,activeColor: AppColors.primaryColor,
                              groupValue: controller.isgiftgiven.value,
                              onChanged: (String? value) {
                                controller.isgiftgiven.value = value!;
                              },
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          );
                        }).toList(),
                      ),]),
                    if(controller.isgiftgiven.value=="Yes")
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [


                        const SizedBox(height: 16),
                        TextField(controller: controller.GiftGivenController.value,
                          decoration: InputDecoration(labelText: 'Gift Given ',
                            labelStyle: const TextStyle(color: AppColors.fountGray),
                            // Change label color
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                              borderRadius: BorderRadius.circular(8.0),
                            ),),
                          // onChanged: (value) => controller.noteDescription.value = value,
                        )
                        ,]),
                    const SizedBox(height: 16),
                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "Smartphone?",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 5),
                    Row(
                      children: controller.radiooptions.map((tag) {
                        return Expanded(
                          child: RadioListTile<String>(
                            title: Text(tag),
                            value: tag,activeColor: AppColors.primaryColor,
                            groupValue: controller.smartphoneOption.value,
                            onChanged: (String? value) {
                              controller.smartphoneOption.value = value!;
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }).toList(),
                    ),
                    if(controller.smartphoneOption.value=="Yes" )
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [ const SizedBox(height: 16),
                        Padding(padding: EdgeInsets.all(5),child:  Text(
                          "${AppConstants.otherApp} downloaded by Nebula Person?",
                          style:  Styles.headerTitel,
                        ),),
                        const SizedBox(height: 5),
                        Wrap(
                          spacing: 0,
                          children: controller.radiooptions.map((tag) {
                            // final isSelected = controller.selectedTags.contains(tag);
                            return RadioListTile<String>(
                              title: Text(tag),
                              value: tag,activeColor: AppColors.primaryColor,
                              groupValue: controller.DownloadApp.value,
                              onChanged: (String? value) {
                                controller.DownloadApp.value = value!;
                              },
                              contentPadding: EdgeInsets.zero, // Removes extra padding
                              visualDensity: VisualDensity.compact, // Reduces spacing
                            );
                          }).toList(),
                        ),],),
                    const SizedBox(height: 16),



                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Participant?", style: Styles.headerTitel),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: controller.radiooptions.map((tag) {
                        return Expanded(
                          child: RadioListTile<String>(
                            title: Text(tag),
                            value: tag,activeColor: AppColors.primaryColor,
                            groupValue: controller.participantOption.value,
                            onChanged: (String? value) {
                              controller.participantOption.value = value!;
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }).toList(),
                    ),



                    if (controller.participantOption.value == "No")
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          DropdownButtonFormField<RoleModel>(
                            value: controller.selectedRoll.value,
                            decoration: InputDecoration(
                              labelText: "Who is Non Participant?",
                              labelStyle: const TextStyle(
                                color: AppColors.fountGray,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.fountGray.withOpacity(0.4),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            items: controller.rolluser.map((
                                RoleModel dealer,
                                ) {
                              return DropdownMenuItem<RoleModel>(
                                value: dealer,
                                child: Text(dealer.fldRole ?? 'Unknown'),
                              );
                            }).toList(),
                            onChanged: (RoleModel? value) {
                              controller.selectedRoll.value = value!;
                              //controller.DealerCodeController.value.text=value.fldRcode!;
                            },
                          ),
                        ],
                      ),



                    // DropdownButtonFormField<String>(
                    //   value: controller.selectedQualification.value.isEmpty
                    //       ? null
                    //       : controller.selectedQualification.value,
                    //   decoration: InputDecoration(
                    //     labelText: 'Qualification',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4)),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: AppColors.fountGray.withOpacity(0.4),
                    //           width: 2.0),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   items: controller.qualificationOptions.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     controller.selectedQualification.value = newValue!;
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // TextField(
                    //   controller: controller.addressController.value,
                    //   maxLines: 3,
                    //   decoration: InputDecoration(
                    //     labelText: 'Address',
                    //     labelStyle: const TextStyle(
                    //       color: AppColors.fountGray,
                    //     ),
                    //     // Change label color
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //       ), // Default border
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //       ), // Unfocused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //         width: 2.0,
                    //       ),
                    //       // Focused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   // onChanged: (value) => controller.noteTitle.value = value,
                    // ),
                    // const SizedBox(height: 16),

                    // const SizedBox(height: 16),
                    // TextField(
                    //   controller: controller.pincodeController.value,
                    //   maxLength: 6,
                    //   keyboardType: TextInputType.number,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.digitsOnly,
                    //   ],
                    //   decoration: InputDecoration(
                    //     labelText: 'Pincode',
                    //     counterText: "",
                    //     labelStyle: const TextStyle(
                    //       color: AppColors.fountGray,
                    //     ),
                    //     // Change label color
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //       ), // Default border
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //       ), // Unfocused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.fountGray.withOpacity(0.4),
                    //         width: 2.0,
                    //       ),
                    //       // Focused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   // onChanged: (value) => controller.noteTitle.value = value,
                    // ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Dealer>(
                      value: controller.selectedDealer.value,
                      decoration: InputDecoration(
                        labelText: "Dealer",
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: controller.dealers.map((Dealer dealer) {
                        return DropdownMenuItem<Dealer>(
                          value: dealer,
                          child: Text(dealer.fldRname ?? 'Unknown'),
                        );
                      }).toList(),
                      onChanged: (Dealer? value) {
                        controller.selectedDealer.value = value!;
                        controller.DealerCodeController.value.text =
                        value.fldRcode!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.DealerCodeController.value,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Dealer Code',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.remark1Controller.value,
                      decoration: InputDecoration(
                        labelText: 'Remarks 1 (Optional)',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.remark2Controller.value,
                      decoration: InputDecoration(
                        labelText: 'Remarks 2 (Optional)',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.remark3Controller.value,
                      decoration: InputDecoration(
                        labelText: 'Remarks 3 (Optional)',
                        labelStyle: const TextStyle(
                          color: AppColors.fountGray,
                        ),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                          ), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.fountGray.withOpacity(0.4),
                            width: 2.0,
                          ),
                          // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Attendee Photos (Optional)',
                      style: Styles.headerTitel,
                    ),
                    const SizedBox(height: 16),
                    promotionimage(context),

                    const SizedBox(height: 26),
                    // Cancel and Submit Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.fountGray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ), // Set the radius here
                                ),
                              ),
                              onPressed: () {
                                Get.back(result: {"status": "success"});
                              },
                              child: Text(
                                "CANCEL".tr,
                                style: const TextStyle(
                                  color: AppColors.whites,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ), // Set the radius here
                                ),
                              ),
                              onPressed: () {
                                controller.validateAndProcess();
                              },
                              child: Text(
                                "SUBMIT".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  Widget promotionimage(BuildContext context) {
    return InkWell(
      onTap: () => controller.takePhoto("p", context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.fld_p_image_path.value.contains("http"))
            Card(
              elevation: 5, // Equivalent to android:elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ), // Equivalent to cardCornerRadius
              ),
              child: Container(
                width: 175, // Equivalent to @dimen/_150sdp
                height: 175, // Equivalent to @dimen/_130sdp
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        controller.fld_p_image_path.value,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit
                            .fill, // Equivalent to android:scaleType="fitXY"
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.deleteNoteAt("p"),
                        // Handle delete action
                        child: Container(
                          width: 30,
                          // Equivalent to @dimen/_30sdp
                          height: 30,
                          // Equivalent to @dimen/_30sdp
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Equivalent to android:color="@color/white"
                            border: Border.all(
                              color: Colors.white,
                              // Equivalent to android:stroke
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              // android:topLeftRadius="20dp"
                              topRight: Radius.circular(6),
                              // android:topRightRadius="6dp"
                              bottomLeft: Radius.circular(0),
                              // android:bottomLeftRadius="0dp"
                              bottomRight: Radius.circular(
                                0,
                              ), // android:bottomRightRadius="0dp"
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            Images.delete_icon,
                            // Equivalent to @drawable/delete_icon
                            width: 15, // Equivalent to @dimen/_15sdp
                            height: 15, // Equivalent to @dimen/_15sdp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (!controller.fld_p_image_path.value.contains("http") &&
              controller.fld_p_image_path.value.isNotEmpty)
            Card(
              elevation: 5, // Equivalent to android:elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ), // Equivalent to cardCornerRadius
              ),
              child: Container(
                width: 175, // Equivalent to @dimen/_150sdp
                height: 175, // Equivalent to @dimen/_130sdp
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(controller.fld_p_image_path.value),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit
                            .fill, // Equivalent to android:scaleType="fitXY"
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.deleteNoteAt("p"),
                        // Handle delete action
                        child: Container(
                          width: 30,
                          // Equivalent to @dimen/_30sdp
                          height: 30,
                          // Equivalent to @dimen/_30sdp
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Equivalent to android:color="@color/white"
                            border: Border.all(
                              color: Colors.white,
                              // Equivalent to android:stroke
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              // android:topLeftRadius="20dp"
                              topRight: Radius.circular(6),
                              // android:topRightRadius="6dp"
                              bottomLeft: Radius.circular(0),
                              // android:bottomLeftRadius="0dp"
                              bottomRight: Radius.circular(
                                0,
                              ), // android:bottomRightRadius="0dp"
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            Images.delete_icon,
                            // Equivalent to @drawable/delete_icon
                            width: 15, // Equivalent to @dimen/_15sdp
                            height: 15, // Equivalent to @dimen/_15sdp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (controller.fld_p_image_path.value.isEmpty)
            Card(
              elevation: 5, // Equivalent to android:elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ), // Equivalent to cardCornerRadius
              ),
              child: Container(
                width: 175,
                // Equivalent to android:layout_width
                height: 175,
                // Equivalent to android:layout_height
                padding: const EdgeInsets.all(10),
                // Equivalent to android:padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Equivalent to android:gravity="center"
                  children: [
                    Image.asset(
                      Images.camera,
                      // Equivalent to android:src="@drawable/camera"
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(height: 10),
                    // Equivalent to android:layout_marginVertical
                    Text(
                      'Take Photo',
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        // Equivalent to android:fontFamily
                        fontSize: 14,
                        // Equivalent to textSize
                        color: AppColors
                            .primaryColor, // Equivalent to android:textColor="@color/primary"
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
