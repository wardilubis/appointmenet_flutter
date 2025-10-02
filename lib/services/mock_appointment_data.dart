import '../models/appointment.dart';

class MockAppointmentData {
  static List<Appointment> getMockAppointments() {
    return [
      Appointment(
        id: 1,
        namaPemohon: 'John Doe',
        emailPemohon: 'john.doe@email.com',
        nomorHpPemohon: '081234567890',
        namaProfesor: 'Prof. Dr. Ahmad Rahman',
        hari: DateTime.now().add(const Duration(days: 1)),
        waktu: '09:00',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Appointment(
        id: 2,
        namaPemohon: 'Jane Smith',
        emailPemohon: 'jane.smith@email.com',
        nomorHpPemohon: '081234567891',
        namaProfesor: 'Prof. Dr. Siti Nurhaliza',
        hari: DateTime.now().add(const Duration(days: 2)),
        waktu: '10:00',
        status: 'approved',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Appointment(
        id: 3,
        namaPemohon: 'Bob Johnson',
        emailPemohon: 'bob.johnson@email.com',
        nomorHpPemohon: '081234567892',
        namaProfesor: 'Prof. Dr. Budi Santoso',
        hari: DateTime.now().add(const Duration(days: 3)),
        waktu: '14:00',
        status: 'rejected',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Appointment(
        id: 4,
        namaPemohon: 'Alice Brown',
        emailPemohon: 'alice.brown@email.com',
        nomorHpPemohon: '081234567893',
        namaProfesor: 'Prof. Dr. Maria Christina',
        hari: DateTime.now().subtract(const Duration(days: 1)),
        waktu: '11:00',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ];
  }
}
