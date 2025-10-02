class AppConfig {
  // Replace this with your actual .NET API base URL
  static const String baseUrl = 'https://localhost:7001/api'; // For local development
  // static const String baseUrl = 'https://your-production-api.com/api'; // For production
  
  // API endpoints
  static const String appointmentsEndpoint = '$baseUrl/appointments';
  
  // HTTP timeout duration
  static const Duration httpTimeout = Duration(seconds: 30);
  
  // App constants
  static const String appName = 'Appointment Manager';
  static const String appVersion = '1.0.0';
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