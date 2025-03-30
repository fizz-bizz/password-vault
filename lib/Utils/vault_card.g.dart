// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaultCardAdapter extends TypeAdapter<VaultCard> {
  @override
  final int typeId = 0;

  @override
  VaultCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VaultCard(
      id: fields[0] as String,
      account: fields[1] as String,
      password: fields[2] as String?,
      isMultiCard: fields[3] as bool,
      subCards: (fields[4] as List?)?.cast<VaultCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, VaultCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.account)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.isMultiCard)
      ..writeByte(4)
      ..write(obj.subCards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaultCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
