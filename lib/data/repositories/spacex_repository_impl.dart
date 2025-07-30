import 'package:dio/dio.dart';
import 'package:galactic_football_league/core/constants/app_constants.dart';
import 'package:galactic_football_league/data/datasources/spacex_provider.dart';
import 'package:galactic_football_league/data/models/rocket_dto.dart';
import 'package:galactic_football_league/domain/models/rocket_team.dart';
import 'package:galactic_football_league/domain/repositories/spacex_repository.dart';
import 'package:hive_ce/hive.dart';

class SpaceXRepositoryImpl implements SpaceXRepository {
  final SpaceXProvider provider;
  final Box<RocketDto> rocketBox;

  SpaceXRepositoryImpl({required this.provider, required this.rocketBox});

  @override
  Future<List<RocketTeam>> getRocketTeams() async {
    try {
      // Пытаемся получить свежие данные
      final rocketsFromApi = await provider.getRockets();
      // Чистим старый кэш и сохраняем новые данные
      await rocketBox.clear();
      await rocketBox.addAll(rocketsFromApi);
      return rocketsFromApi.map(_mapDtoToDomain).toList();
    } on DioException catch (e) {
      // Если ошибка сети - достаем из кэша
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.unknown) {
        final rocketsFromCache = rocketBox.values.toList();
        return rocketsFromCache.map(_mapDtoToDomain).toList();
      }
      // Другие ошибки можно обработать иначе
      rethrow;
    }
  }

  // Маппер из DTO в доменную модель
  RocketTeam _mapDtoToDomain(RocketDto dto) {
    return RocketTeam(
      id: dto.id,
      name: dto.name,
      photoUrl: dto.flickrImages.isNotEmpty ? dto.flickrImages.first : '',
      description: dto.description,
      // Упрощенный расчет "статов" для примера
      power: (dto.mass / 1000).round(),
      defense: (dto.height * 10).round(),
    );
  }
}