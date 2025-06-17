import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF22C55E);
  static const Color secondaryLight = Color(0xFF4ADE80);
  static const Color secondaryDark = Color(0xFF16A34A);
  
  // Accent Colors
  static const Color accent = Color(0xFFD946EF);
  static const Color accentLight = Color(0xFFE879F9);
  static const Color accentDark = Color(0xFFC026D3);
  
  // Neutral Colors
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}