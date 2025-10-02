// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
  id: (json['id'] as num).toInt(),
  namaPemohon: json['namaPemohon'] as String,
  emailPemohon: json['emailPemohon'] as String,
  nomorHpPemohon: json['nomorHpPemohon'] as String,
  namaProfesor: json['namaProfesor'] as String,
  hari: DateTime.parse(json['hari'] as String),
  waktu: json['waktu'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'namaPemohon': instance.namaPemohon,
      'emailPemohon': instance.emailPemohon,
      'nomorHpPemohon': instance.nomorHpPemohon,
      'namaProfesor': instance.namaProfesor,
      'hari': instance.hari.toIso8601String(),
      'waktu': instance.waktu,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
