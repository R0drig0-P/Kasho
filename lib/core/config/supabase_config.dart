import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase credentials - configured!
  static const String supabaseUrl = 'https://fcxnjplbfxjurwscvlcs.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZjeG5qcGxiZnhqdXJ3c2N2bGNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ1MTIzNDQsImV4cCI6MjA4MDA4ODM0NH0.lN_CeowLvXqtzLOJKrF_jDeT3ieegiffRglwWzC6T3o';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
