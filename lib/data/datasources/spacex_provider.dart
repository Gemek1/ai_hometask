import 'package:dio/dio.dart';
import 'package:galactic_football_league/data/models/launch_dto.dart';
import 'package:galactic_football_league/data/models/rocket_dto.dart';

class SpaceXProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.spacexdata.com'));

  Future<List<RocketDto>> getRockets() async {
    final response = await _dio.get('/v4/rockets');
    return (response.data as List)
        .map((rocketJson) => RocketDto.fromJson(rocketJson))
        .toList();
  }

  Future<List<LaunchDto>> getPastLaunches() async {
    final response = await _dio.get('/v4/launches/past');
    return (response.data as List)
        .map((launchJson) => LaunchDto.fromJson(launchJson))
        .toList();
  }
}