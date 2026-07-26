class AppInfoModel {
  final String appName;
  final String version;
  final String dateOfManufacture;
  final String language;

  const AppInfoModel({
    required this.appName,
    required this.version,
    required this.dateOfManufacture,
    required this.language
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      appName: json['app_name'] ,
      version: json['version'],
      dateOfManufacture: json['date_of_manufacture'],
      language: json['language']
    );
  }
}