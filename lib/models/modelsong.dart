// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import "package:equatable/equatable.dart";

part 'modelsong.g.dart';

@HiveType(typeId: 1)
class ModelSong extends Equatable {
  @HiveField(0)
  String? artiseName;
  @HiveField(1)
  String? songName;
  @HiveField(2)
  String? urlImageAlbum;
  @HiveField(3)
  String? urlSong;
  @HiveField(4)
  String? songModelencode;
  ModelSong(
      {this.artiseName,
      this.songName,
      this.urlImageAlbum,
      this.urlSong,
      this.songModelencode});

  @override
  List<Object> get props => [
        artiseName!,
        songName!,
        urlImageAlbum!,
        urlSong!,
      ];
}
