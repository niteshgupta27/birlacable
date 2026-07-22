class QuestionResponse {
  final bool status;
  final bool isSubmitted;
  final List<QuestionData> data;

  QuestionResponse({
    required this.status,
    required this.isSubmitted,
    required this.data,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      status: json['status'] ?? false,
      isSubmitted: json['is_submitted'] ?? false,
      data: (json['data'] as List? ?? [])
          .map((item) => QuestionData.fromJson(item))
          .toList(),
    );
  }
}

class QuestionData {
  final int id;
  final String question;
  final List<String> options;
  String? selectedOption;

  QuestionData({
    required this.id,
    required this.question,
    required this.options,
    this.selectedOption,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }
}
