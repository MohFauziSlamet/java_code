// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      idUser: fields[1] as int?,
      email: fields[2] as String?,
      nama: fields[3] as String?,
      pin: fields[4] as String?,
      foto: fields[5] as String?,
      mRolesId: fields[6] as int?,
      isGoogle: fields[7] as int?,
      isCustomer: fields[8] as int?,
      roles: fields[9] as String?,
      akses: fields[10] as Akses?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(1)
      ..write(obj.idUser)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.nama)
      ..writeByte(4)
      ..write(obj.pin)
      ..writeByte(5)
      ..write(obj.foto)
      ..writeByte(6)
      ..write(obj.mRolesId)
      ..writeByte(7)
      ..write(obj.isGoogle)
      ..writeByte(8)
      ..write(obj.isCustomer)
      ..writeByte(9)
      ..write(obj.roles)
      ..writeByte(10)
      ..write(obj.akses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      idUser: json['id_user'] as int?,
      email: json['email'] as String?,
      nama: json['nama'] as String?,
      pin: json['pin'] as String?,
      foto: json['foto'] as String?,
      mRolesId: json['m_roles_id'] as int?,
      isGoogle: json['is_google'] as int?,
      isCustomer: json['is_customer'] as int?,
      roles: json['roles'] as String?,
      akses: json['akses'] == null
          ? null
          : Akses.fromJson(json['akses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id_user': instance.idUser,
      'email': instance.email,
      'nama': instance.nama,
      'pin': instance.pin,
      'foto': instance.foto,
      'm_roles_id': instance.mRolesId,
      'is_google': instance.isGoogle,
      'is_customer': instance.isCustomer,
      'roles': instance.roles,
      'akses': instance.akses,
    };
