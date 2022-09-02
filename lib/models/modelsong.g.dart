// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelsong.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelSongAdapter extends TypeAdapter<ModelSong> {
  @override
  final int typeId = 1;

  @override
  ModelSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelSong(
      artiseName: fields[0] as String?,
      songName: fields[1] as String?,
      urlImageAlbum: fields[2] as String?,
      urlSong: fields[3] as String?,
      songModelencode: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelSong obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.artiseName)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.urlImageAlbum)
      ..writeByte(3)
      ..write(obj.urlSong)
      ..writeByte(4)
      ..write(obj.songModelencode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
