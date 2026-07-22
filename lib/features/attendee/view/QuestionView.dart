import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../controller/QuestionController.dart';

class QuestionView extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whites,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Test Questions",
          style: Styles.headerTitel,
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        shadowColor: AppColors.gray.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CustomLoaderWidget(color: AppColors.primaryColor);
          }

          if (controller.questions.isEmpty) {
            return const Center(child: Text("No questions available"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    final question = controller.questions[index];
                    return Card(color: AppColors.whites,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Q${index + 1}: ${question.question}",
                              style: Styles.headerTitel.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            ...question.options.map((option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: question.selectedOption,
                                activeColor: AppColors.primaryColor,
                                onChanged: controller.isSubmitted.value
                                    ? null
                                    : (value) => controller.onOptionSelected(index, value!),
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!controller.isSubmitted.value)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => controller.submitSurvey(),
                      child: const Text(
                        "SUBMIT SURVEY",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
