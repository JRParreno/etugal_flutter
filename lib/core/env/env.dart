abstract final class Env {
  static const clientId = String.fromEnvironment('CLIENT_ID');
  static const clientSecret = String.fromEnvironment('CLIENT_SECRET');
  static const apiURL = String.fromEnvironment('API_URL');
}
