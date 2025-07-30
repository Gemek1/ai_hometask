import 'package:equatable/equatable.dart';

class RocketTeam extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final int power;
  final int defense;

  const RocketTeam({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.power,
    required this.defense,
  });

  @override
  List<Object?> get props => [id, name, photoUrl, description, power, defense];
}