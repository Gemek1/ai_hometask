import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String id;
  final String name;
  final String planetName;
  final int power;
  final int defense;
  final int speed;

  const Team({
    required this.id,
    required this.name,
    required this.planetName,
    required this.power,
    required this.defense,
    required this.speed,
  });

  @override
  List<Object?> get props => [id, name, planetName, power, defense, speed];
}