import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';
import '../config/app_config.dart';

class AppointmentService {
  // Get all appointments
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(AppConfig.appointmentsEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Appointment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
    }
  }

  // Get appointment by ID
  Future<Appointment> getAppointmentById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.appointmentsEndpoint}/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else {
        throw Exception('Failed to load appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointment: $e');
    }
  }

  // Create new appointment
  Future<Appointment> createAppointment(Map<String, dynamic> appointmentData) async {
    try {
      final response = await http.post(
        Uri.parse(AppConfig.appointmentsEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(appointmentData),
      ).timeout(AppConfig.httpTimeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else {
        throw Exception('Failed to create appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating appointment: $e');
    }
  }

  // Update appointment
  Future<Appointment> updateAppointment(int id, Map<String, dynamic> appointmentData) async {
    try {
      final response = await http.put(
        Uri.parse('${AppConfig.appointmentsEndpoint}/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(appointmentData),
      ).timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else {
        throw Exception('Failed to update appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating appointment: $e');
    }
  }

  // Delete appointment
  Future<bool> deleteAppointment(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppConfig.appointmentsEndpoint}/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(AppConfig.httpTimeout);

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Error deleting appointment: $e');
    }
  }

  // Update appointment status
  Future<Appointment> updateAppointmentStatus(int id, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('${AppConfig.appointmentsEndpoint}/$id/status'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'status': status}),
      ).timeout(AppConfig.httpTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Appointment.fromJson(jsonData);
      } else {
        throw Exception('Failed to update appointment status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating appointment status: $e');
    }
  }
}