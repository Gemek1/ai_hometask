import 'package:hive_ce/hive.dart';

class TeamDto extends HiveObject {
  final String id;
  final String name;
  final String planetName;
  final int power;
  final int defense;
  final int speed;

  TeamDto({
    required this.id,
    required this.name,
    required this.planetName,
    required this.power,
    required this.defense,
    required this.speed,
  });
}