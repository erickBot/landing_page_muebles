import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/ui/widgets/shimmer_network_image.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagenes = [
      'assets/img/mueble_cocina.jpg',
      'assets/img/mueble_closet.png',
      'assets/img/mueble_escritorio.png',
      'assets/img/mueble_tv.png',
      'assets/img/mueble_comoda.png',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;
        bool isSmall = constraints.maxWidth < 650;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kColorFondo, // Lila muy suave
                kColorFondoD,
                kColorAcento, // Azul lavanda pastel
                // kColorPrimario, // Blanco para suavizar la parte inferior
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📝 Texto principal
              Flexible(
                flex: isMobile ? 0 : 1,
                child: Container(
                  width: isMobile ? double.infinity : 600,
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '✨ Tu mueble',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.lato(
                            fontSize: isMobile ? 36 : 50,
                            color: Color(0xFF1A1E2C),
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Construye fácilmente con nuestros planos profesionales de muebles de melamina.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.lato(
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Convierte tus ideas en proyectos reales con nuestros planos listos para fabricar. '
                          'Cada diseño está optimizado para ahorrar material, reducir errores y maximizar tus ganancias.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.lato(
                            fontSize: isMobile ? 14 : 16,
                            color: Color(0xFF6B7280), // Gris azulado suave
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Ya seas carpintero, estudiante o aficionado, aquí encontrarás planos exactos, modernos y 100% funcionales, listos para cortar, ensamblar y vender.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.lato(
                            fontSize: isMobile ? 14 : 16,
                            color: Color(0xFF6B7280), // Gris azulado suave
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '🔧 Diseños precisos. Resultados profesionales. Melamina sin límites.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.lato(
                            fontSize: isMobile ? 14 : 16,
                            color: Color(0xFF6B7280), // Gris azulado suave
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10, width: 30),

              // 🖼 Carrusel de imágenes
              Consumer<DataProvider>(
                builder: (context, value, child) => Flexible(
                  flex: isMobile ? 0 : 1,
                  child: Container(
                    width: isMobile ? double.infinity : 400,
                    height: isSmall
                        ? 165
                        : isMobile
                        ? 250
                        : 500,
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: double.infinity,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          aspectRatio: isMobile ? 16 / 8 : 4 / 5,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 800,
                          ),
                        ),
                        items: value.currentImages.map((element) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ShimmerNetworkImage(
                                imageUrl: element.image!,
                                fit: BoxFit.cover,
                                baseColor: kColorFondo,
                                highlightColor: kColorFondoD,
                                width: isMobile ? double.infinity : 400,
                                height: isSmall
                                    ? 165
                                    : isMobile
                                    ? 250
                                    : 500,
                              );
                              // return FadeInImage(
                              //   placeholder: const AssetImage(
                              //     'assets/img/loading_image.gif',
                              //   ),
                              //   image: NetworkImage(element.image!),
                              //   fit: BoxFit.cover,
                              // );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
