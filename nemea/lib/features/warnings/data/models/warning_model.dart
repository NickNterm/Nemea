class WarningModel {
  final String title;
  final String? description;
  final String datetime;

  WarningModel({
    required this.title,
    required this.description,
    required this.datetime,
  });

  factory WarningModel.fromJson(Map<String, dynamic> json) {
    return WarningModel(
      title: json['title'],
      description: json['description'],
      datetime: json['datetime'],
    );
  }
}
