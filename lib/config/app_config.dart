class AppConfig {
  // Replace this with your actual .NET API base URL
  static const String baseUrl = 'http://localhost:5157/api';

  static const String appointmentsEndpoint = '$baseUrl/appointments';

  static const Duration httpTimeout = Duration(seconds: 30);

  static const String appName = 'Appointment Manager';
  static const String appVersion = '1.0.0';

  static const bool enableCorsDebugging = true;

  static String getAppointmentByIdEndpoint(int id) =>
      '$appointmentsEndpoint/$id';

  static String getAppointmentsByStatusEndpoint(String status) =>
      '$appointmentsEndpoint/status/$status';

  static String getAppointmentsByProfesorEndpoint(String namaProfesor) =>
      '$appointmentsEndpoint/profesor/$namaProfesor';
}

// Development/Production environment configurations
class Environment {
  static const String development = 'development';
  static const String production = 'production';

  // Current environment
  static const String current = development;

  static bool get isDevelopment => current == development;
  static bool get isProduction => current == production;
}
