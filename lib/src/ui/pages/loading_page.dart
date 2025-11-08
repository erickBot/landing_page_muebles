import 'package:flutter/material.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Fondo degradado suave
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kColorFondo, // Lila muy suave
              kColorFondoD,
              kColorAcento, // Azul lavanda pastel
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.6),
            highlightColor: Colors.white,
            period: const Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.precision_manufacturing_rounded,
                  size: 110,
                  color: kColorTexto,
                ),
                SizedBox(height: 28),
                Text(
                  'Cargando Tu-Mueble.com...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                    color: kColorTexto,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
