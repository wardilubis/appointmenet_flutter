import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';
import '../config/app_config.dart';
import 'mock_appointment_data.dart';

class AppointmentService {
  // HTTP headers untuk semua request
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Flag untuk menggunakan mock data
  static const bool useMockData =
      false; // Set true untuk testing UI tanpa backend

  // GET /api/appointments - GetAppointments()
  Future<List<Appointment>> getAppointments() async {
    // Gunakan mock data jika flag enabled
    if (useMockData) {
      await Future.delayed(const Duration(seconds: 1));
      return MockAppointmentData.getMockAppointments();
    }

    try {
      final response = await http
          .get(Uri.parse(AppConfig.appointmentsEndpoint), headers: _headers)
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Appointment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load appointments: ${response.statusCode}');
      }
    } catch (e) {
      // Check if it's a CORS error
      if (e.toString().contains('failed to fetch') ||
          e.toString().contains('CORS') ||
          e.toString().contains('XMLHttpRequest')) {
        throw Exception(
          'CORS Error: Tidak dapat mengakses API backend.\n'
          'Pastikan:\n'
          '1. Backend API berjalan di ${AppConfig.baseUrl}\n'
          '2. CORS sudah dikonfigurasi untuk Flutter web\n'
          '3. Controller API dapat diakses\n\n'
          'Untuk testing UI, ubah useMockData = true di AppointmentService.\n'
          'Detail error: $e',
        );
      }

      throw Exception('Error fetching appointments: $e');
    }
  }

  // GET /api/appointments/{id} - GetAppointment(int id)
  Future<Appointment> getAppointmentById(int id) async {
    try {
      final response = await http
          .get(
            Uri.parse(AppConfig.getAppointmentByIdEndpoint(id)),
            headers: _headers,
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Appointment dengan ID $id tidak ditemukan!');
      } else {
        throw Exception('Failed to load appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointment: $e');
    }
  }

  // POST /api/appointments - CreateAppointment(CreateAppointmentDto)
  Future<Appointment> createAppointment(
    Map<String, dynamic> appointmentData,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse(AppConfig.appointmentsEndpoint),
            headers: _headers,
            body: json.encode(appointmentData),
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        throw Exception(
          'Gagal membuat appointment: ${errorData['message'] ?? 'Invalid data'}',
        );
      } else {
        throw Exception('Failed to create appointment: ${response.statusCode}');
      }
    } catch (e) {
      // Check if it's a CORS error
      if (e.toString().contains('failed to fetch') ||
          e.toString().contains('CORS') ||
          e.toString().contains('XMLHttpRequest')) {
        throw Exception(
          'CORS Error: Pastikan backend API sudah mengizinkan Flutter web.\n'
          'Tambahkan CORS configuration di backend .NET API Anda.\n'
          'Detail error: $e',
        );
      }

      throw Exception('Error creating appointment: $e');
    }
  }

  // PUT /api/appointments/{id} - UpdateAppointment(int id, UpdateAppointmentDto)
  Future<Appointment> updateAppointment(
    int id,
    Map<String, dynamic> appointmentData,
  ) async {
    try {
      final response = await http
          .put(
            Uri.parse(AppConfig.getAppointmentByIdEndpoint(id)),
            headers: _headers,
            body: json.encode(appointmentData),
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Appointment dengan ID $id tidak ditemukan!');
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        throw Exception(
          'Gagal update appointment: ${errorData['message'] ?? 'Invalid data'}',
        );
      } else {
        throw Exception('Failed to update appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating appointment: $e');
    }
  }

  // DELETE /api/appointments/{id} - DeleteAppointment(int id)
  Future<bool> deleteAppointment(int id) async {
    try {
      final response = await http
          .delete(
            Uri.parse(AppConfig.getAppointmentByIdEndpoint(id)),
            headers: _headers,
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        throw Exception('Appointment dengan ID $id tidak ditemukan!');
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error deleting appointment: $e');
    }
  }

  // GET /api/appointments/status/{status} - GetAppointmentsByStatus(string status)
  Future<List<Appointment>> getAppointmentsByStatus(String status) async {
    try {
      final response = await http
          .get(
            Uri.parse(AppConfig.getAppointmentsByStatusEndpoint(status)),
            headers: _headers,
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Appointment.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load appointments by status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching appointments by status: $e');
    }
  }

  // GET /api/appointments/profesor/{namaProfesor} - GetAppointmentsByProfesor(string namaProfesor)
  Future<List<Appointment>> getAppointmentsByProfesor(
    String namaProfesor,
  ) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              AppConfig.getAppointmentsByProfesorEndpoint(namaProfesor),
            ),
            headers: _headers,
          )
          .timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Appointment.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load appointments by profesor: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching appointments by profesor: $e');
    }
  }

  // Helper method untuk update status menggunakan PUT dengan data lengkap
  Future<Appointment> updateAppointmentStatus(int id, String status) async {
    try {
      // Pertama ambil data appointment yang ada
      final currentAppointment = await getAppointmentById(id);

      // Update hanya status
      final updateData = {
        'namaPemohon': currentAppointment.namaPemohon,
        'emailPemohon': currentAppointment.emailPemohon,
        'nomorHpPemohon': currentAppointment.nomorHpPemohon,
        'namaProfesor': currentAppointment.namaProfesor,
        'hari': currentAppointment.hari.toIso8601String(),
        'waktu': currentAppointment.waktu,
        'status': status,
      };

      return await updateAppointment(id, updateData);
    } catch (e) {
      throw Exception('Error updating appointment status: $e');
    }
  }
}
