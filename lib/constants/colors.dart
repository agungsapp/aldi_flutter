import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0770CD);
  static const Color secondary = Color(0xFF0099FF);
  static const Color background = Color(0xFFF8FAFE);
  static const Color border = Color(0xFFE1E8ED);
  static const LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0770CD), Color(0xFFF8FAFE)],
    stops: [0.0, 0.4],
  );
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF0770CD), Color(0xFF0099FF)],
  );
  static const LinearGradient registerButtonGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
  );
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}
