import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final int id;
  final String namaPemohon;
  final String emailPemohon;
  final String nomorHpPemohon;
  final String namaProfesor;
  final DateTime hari;
  final String waktu;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.namaPemohon,
    required this.emailPemohon,
    required this.nomorHpPemohon,
    required this.namaProfesor,
    required this.hari,
    required this.waktu,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  // Helper method to get formatted date
  String get formattedDate => '${hari.day}/${hari.month}/${hari.year}';

  // Helper method to get status color
  AppointmentStatus get appointmentStatus {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppointmentStatus.pending;
      case 'approved':
        return AppointmentStatus.approved;
      case 'rejected':
        return AppointmentStatus.rejected;
      case 'completed':
        return AppointmentStatus.completed;
      default:
        return AppointmentStatus.pending;
    }
  }
}

enum AppointmentStatus { pending, approved, rejected, completed }
