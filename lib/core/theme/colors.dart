import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF007AFF); // Electric Blue
  static const Color secondary = Color(0xFF34C759); // Neon Green
  static const Color background = Color(0xFF0A0A0B); // Minimalist Dark Background
  static const Color cardBackground = Color(0xFF161618); // Darker gray for cards
  static const Color textBody = Color(0xFFEBEBF5); // High-emphasis text
  static const Color textCaption = Color(0x99EBEBF5); // Low-emphasis text
  static const Color accent = Color(0xFFFFCC00); // Yellow for XP or streaks
  static const Color danger = Color(0xFFFF3B30); // Red for destructive actions
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF47A1FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFF64DF81)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
