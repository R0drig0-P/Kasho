import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiConfig {
  // Load from .env file for security
  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  // Model configurations
  static const String visionModel =
      'gemini-2.0-flash-exp'; // For receipt scanning
  static const String textModel =
      'gemini-2.0-flash-exp'; // For categorization & insights
}
