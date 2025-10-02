class TimeFormatter {
  // Convert backend time format (HH:mm) to user-friendly display (HH:mm - HH:mm)
  static String formatTimeForDisplay(String backendTime) {
    try {
      // Parse waktu dari backend (format: "14:30")
      final parts = backendTime.split(':');
      if (parts.length != 2) return backendTime;

      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      // Buat waktu mulai
      final startTime =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

      // Buat waktu selesai (1 jam setelahnya)
      final endHour = hour + 1;
      final endTime =
          '${endHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

      return '$startTime - $endTime';
    } catch (e) {
      return backendTime; // Return original jika parsing gagal
    }
  }

  // Convert user-friendly display time to backend format
  static String formatTimeForBackend(String displayTime) {
    try {
      // Jika sudah format backend (HH:mm), return as is
      if (!displayTime.contains(' - ')) {
        return displayTime;
      }

      // Parse dari format "HH:mm - HH:mm" dan ambil waktu mulai
      final parts = displayTime.split(' - ');
      if (parts.isNotEmpty) {
        return parts[0]; // Return waktu mulai saja
      }

      return displayTime;
    } catch (e) {
      return displayTime;
    }
  }

  // Get time slots with user-friendly display
  static List<Map<String, String>> getTimeSlots() {
    final List<String> backendTimes = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
    ];

    return backendTimes
        .map((time) => {'backend': time, 'display': formatTimeForDisplay(time)})
        .toList();
  }
}
