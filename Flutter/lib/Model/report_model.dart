class ReportModel {
  final String title;
  final String imagePath;
  final String diagnosis;
  final String date;

  ReportModel({
    required this.title,
    required this.imagePath,
    required this.diagnosis,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'imagePath': imagePath,
    'diagnosis': diagnosis,
    'date': date,
  };

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    title: json['title'],
    imagePath: json['imagePath'],
    diagnosis: json['diagnosis'],
    date: json['date'],
  );
}
