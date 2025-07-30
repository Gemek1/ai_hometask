// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class LeagueStandingAdapter extends TypeAdapter<LeagueStanding> {
  @override
  final typeId = 0;

  @override
  LeagueStanding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeagueStanding(
      team: fields[0] as Team,
      wins: (fields[1] as num).toInt(),
      losses: (fields[2] as num).toInt(),
      draws: (fields[3] as num).toInt(),
      points: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, LeagueStanding obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.team)
      ..writeByte(1)
      ..write(obj.wins)
      ..writeByte(2)
      ..write(obj.losses)
      ..writeByte(3)
      ..write(obj.draws)
      ..writeByte(4)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeagueStandingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewsItemAdapter extends TypeAdapter<NewsItem> {
  @override
  final typeId = 1;

  @override
  NewsItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsItem(
      id: fields[0] as String,
      title: fields[1] as String,
      contentTemplateKey: fields[2] as String,
      date: fields[3] as DateTime,
      team1Name: fields[4] as String,
      team2Name: fields[5] as String,
      score1: (fields[6] as num).toInt(),
      score2: (fields[7] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.contentTemplateKey)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.team1Name)
      ..writeByte(5)
      ..write(obj.team2Name)
      ..writeByte(6)
      ..write(obj.score1)
      ..writeByte(7)
      ..write(obj.score2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamAdapter extends TypeAdapter<Team> {
  @override
  final typeId = 2;

  @override
  Team read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Team(
      id: fields[0] as String,
      name: fields[1] as String,
      planetName: fields[2] as String,
      power: (fields[3] as num).toInt(),
      defense: (fields[4] as num).toInt(),
      speed: (fields[5] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Team obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.planetName)
      ..writeByte(3)
      ..write(obj.power)
      ..writeByte(4)
      ..write(obj.defense)
      ..writeByte(5)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MatchResultAdapter extends TypeAdapter<MatchResult> {
  @override
  final typeId = 3;

  @override
  MatchResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchResult(
      id: fields[0] as String,
      team1: fields[1] as Team,
      team2: fields[2] as Team,
      score1: (fields[3] as num).toInt(),
      score2: (fields[4] as num).toInt(),
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MatchResult obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.team1)
      ..writeByte(2)
      ..write(obj.team2)
      ..writeByte(3)
      ..write(obj.score1)
      ..writeByte(4)
      ..write(obj.score2)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamDtoAdapter extends TypeAdapter<TeamDto> {
  @override
  final typeId = 4;

  @override
  TeamDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamDto(
      id: fields[0] as String,
      name: fields[1] as String,
      planetName: fields[2] as String,
      power: (fields[3] as num).toInt(),
      defense: (fields[4] as num).toInt(),
      speed: (fields[5] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TeamDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.planetName)
      ..writeByte(3)
      ..write(obj.power)
      ..writeByte(4)
      ..write(obj.defense)
      ..writeByte(5)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RocketDtoAdapter extends TypeAdapter<RocketDto> {
  @override
  final typeId = 5;

  @override
  RocketDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RocketDto(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      height: (fields[3] as num).toInt(),
      mass: (fields[4] as num).toInt(),
      flickrImages: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RocketDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.mass)
      ..writeByte(5)
      ..write(obj.flickrImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RocketDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LaunchDtoAdapter extends TypeAdapter<LaunchDto> {
  @override
  final typeId = 6;

  @override
  LaunchDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaunchDto(
      id: fields[0] as String,
      name: fields[1] as String,
      date: fields[2] as DateTime,
      success: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LaunchDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.success);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaunchDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
