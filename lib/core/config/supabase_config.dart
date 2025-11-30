import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // TODO: Add your Supabase credentials here
  // Get these from: https://supabase.com/dashboard/project/_/settings/api
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
