import 'package:hive_ce/hive.dart';

class RocketDto extends HiveObject {
  final String id;
  final String name;
  final String description;
  final int height;
  final int mass;
  final List<String> flickrImages;

  RocketDto({
    required this.id,
    required this.name,
    required this.description,
    required this.height,
    required this.mass,
    required this.flickrImages,
  });

  factory RocketDto.fromJson(Map<String, dynamic> json) {
    return RocketDto(
      id: json['id'] as String, // ID и имя считаем обязательными
      name: json['name'] as String,
      description: json['description'] ?? 'No description available',

      // ✅ Исправление: Если height_m или mass.kg приходят как null, используем 0
      height: (json['height_m'] ?? 0).toInt(),
      mass: (json['mass']?['kg'] ?? 0).toInt(),

      // ✅ Исправление: Если список картинок пуст, создаем пустой список
      flickrImages: List<String>.from(json['flickr_images'] ?? []),
    );
  }
}