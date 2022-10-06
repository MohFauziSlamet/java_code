// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToppingHiveAdapter extends TypeAdapter<ToppingHive> {
  @override
  final int typeId = 5;

  @override
  ToppingHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToppingHive(
      idDetail: fields[0] as int?,
      idMenu: fields[1] as int?,
      keterangan: fields[2] as String?,
      type: fields[3] as String?,
      harga: fields[4] as int?,
      isSelected: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ToppingHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idDetail)
      ..writeByte(1)
      ..write(obj.idMenu)
      ..writeByte(2)
      ..write(obj.keterangan)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.harga)
      ..writeByte(5)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToppingHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
