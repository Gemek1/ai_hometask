import 'package:hive_ce/hive.dart';

class LaunchDto extends HiveObject {
  final String id;
  final String name;
  final DateTime date;
  final bool success;

  LaunchDto({
    required this.id,
    required this.name,
    required this.date,
    required this.success,
  });

  factory LaunchDto.fromJson(Map<String, dynamic> json) {
    return LaunchDto(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date_utc']),
      success: json['success'] ?? false,
    );
  }
}