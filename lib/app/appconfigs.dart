class EnvironmentConfig {
  static const BASE_URL = String.fromEnvironment('BASE_URL');
  static const String LOCAL_LAPTOP_URL = "http://192.168.0.149:8080/scm";
  static const String LOCAL_URL = "http://192.168.0.193:8080/scm";
  static const String PROD_URL = "http://geekscms.com";
  static const SHOW_LOGS = bool.fromEnvironment('SHOW_LOGS');
  static const VAPID_KEY = String.fromEnvironment('VAPID_KEY');
}
