import 'package:flutter/foundation.dart';
import '../models/appointment.dart';
import '../services/appointment_service.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();

  List<Appointment> _appointments = [];
  Appointment? _selectedAppointment;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Appointment> get appointments => _appointments;
  Appointment? get selectedAppointment => _selectedAppointment;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Filter appointments by status
  List<Appointment> getAppointmentsByStatus(AppointmentStatus status) {
    return _appointments
        .where((appointment) => appointment.appointmentStatus == status)
        .toList();
  }

  // Get today's appointments
  List<Appointment> getTodaysAppointments() {
    final today = DateTime.now();
    return _appointments
        .where(
          (appointment) =>
              appointment.hari.year == today.year &&
              appointment.hari.month == today.month &&
              appointment.hari.day == today.day,
        )
        .toList();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Fetch all appointments
  Future<void> fetchAppointments() async {
    _setLoading(true);
    _setError(null);

    try {
      _appointments = await _appointmentService.getAppointments();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Fetch appointment by ID
  Future<void> fetchAppointmentById(int id) async {
    _setLoading(true);
    _setError(null);

    try {
      _selectedAppointment = await _appointmentService.getAppointmentById(id);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Create new appointment
  Future<bool> createAppointment({
    required String namaPemohon,
    required String emailPemohon,
    required String nomorHpPemohon,
    required String namaProfesor,
    required DateTime hari,
    required String waktu,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final appointmentData = {
        'namaPemohon': namaPemohon,
        'emailPemohon': emailPemohon,
        'nomorHpPemohon': nomorHpPemohon,
        'namaProfesor': namaProfesor,
        'hari': hari.toIso8601String(),
        'waktu': waktu,
        'status': 'pending',
      };

      final newAppointment = await _appointmentService.createAppointment(
        appointmentData,
      );
      _appointments.add(newAppointment);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update appointment
  Future<bool> updateAppointment(
    int id,
    Map<String, dynamic> appointmentData,
  ) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedAppointment = await _appointmentService.updateAppointment(
        id,
        appointmentData,
      );
      final index = _appointments.indexWhere(
        (appointment) => appointment.id == id,
      );
      if (index != -1) {
        _appointments[index] = updatedAppointment;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Delete appointment
  Future<bool> deleteAppointment(int id) async {
    _setLoading(true);
    _setError(null);

    try {
      final success = await _appointmentService.deleteAppointment(id);
      if (success) {
        _appointments.removeWhere((appointment) => appointment.id == id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update appointment status
  Future<bool> updateAppointmentStatus(int id, String status) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedAppointment = await _appointmentService
          .updateAppointmentStatus(id, status);
      final index = _appointments.indexWhere(
        (appointment) => appointment.id == id,
      );
      if (index != -1) {
        _appointments[index] = updatedAppointment;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Fetch appointments by status dari API
  Future<void> fetchAppointmentsByStatusFromAPI(String status) async {
    _setLoading(true);
    _setError(null);

    try {
      _appointments = await _appointmentService.getAppointmentsByStatus(status);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Fetch appointments by profesor dari API
  Future<void> fetchAppointmentsByProfesorFromAPI(String namaProfesor) async {
    _setLoading(true);
    _setError(null);

    try {
      _appointments = await _appointmentService.getAppointmentsByProfesor(
        namaProfesor,
      );
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Get unique professors dari appointments yang sudah diload
  List<String> getUniqueProfessors() {
    final professors = _appointments
        .map((appointment) => appointment.namaProfesor)
        .toSet()
        .toList();
    professors.sort();
    return professors;
  }
}
