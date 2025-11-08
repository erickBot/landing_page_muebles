import 'package:flutter/material.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/ui/widgets/shimmer_network_image.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  'Sobre Nosotros',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Transformamos la forma en que se diseñan y fabrican los muebles de melamina.',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
                const SizedBox(height: 40),

                // Sección de historia + imagen
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Texto
                    Expanded(
                      flex: isMobile ? 0 : 1,
                      child: Column(
                        crossAxisAlignment: isMobile
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nuestra Historia',
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Tu-mueble.com nació con la misión de ayudar a carpinteros, diseñadores y aficionados a convertir sus ideas '
                            'en proyectos reales. Nos especializamos en la creación de planos de muebles de melamina listos para fabricar, '
                            'con medidas exactas, instrucciones claras y diseños modernos.',
                            textAlign: isMobile
                                ? TextAlign.center
                                : TextAlign.start,
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'A lo largo del tiempo, hemos trabajado con profesionales del rubro para optimizar cada diseño, garantizando '
                            'el máximo aprovechamiento del material.',
                            textAlign: isMobile
                                ? TextAlign.center
                                : TextAlign.start,
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? 0 : 40,
                      height: isMobile ? 30 : 0,
                    ),
                    // Imagen decorativa
                    Consumer<DataProvider>(
                      builder: (context, value, child) => Expanded(
                        flex: isMobile ? 0 : 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: ShimmerNetworkImage(
                            imageUrl: value.currentUtil.imageUrl!,
                            fit: BoxFit.cover,
                            baseColor: kColorFondo,
                            highlightColor: kColorFondoD,
                            width: double.infinity,
                            height: isMobile ? 200 : 300,
                          ),
                          // child: FadeInImage(
                          //   width: double.infinity,
                          //   height: isMobile ? 200 : 300,
                          //   placeholder: AssetImage(
                          //     'assets/img/loading_image.gif',
                          //   ),
                          //   image: NetworkImage(value.currentUtil.imageUrl!),
                          //   fit: BoxFit.cover,
                          // ),
                          // child: Image.asset(
                          //   'assets/img/nosotros_taller.png',
                          //   fit: BoxFit.cover,
                          //   height: isMobile ? 200 : 300,
                          //   width: double.infinity,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Misión y visión
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: isMobile ? 0 : 1,
                      child: _MissionCard(
                        icon: Icons.flag_rounded,
                        title: 'Nuestra Misión',
                        text:
                            'Facilitar el acceso a planos profesionales y precisos de muebles de melamina, impulsando el crecimiento de carpinteros y emprendedores.',
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? 0 : 20,
                      height: isMobile ? 20 : 0,
                    ),
                    Expanded(
                      flex: isMobile ? 0 : 1,
                      child: _MissionCard(
                        icon: Icons.remove_red_eye_rounded,
                        title: 'Nuestra Visión',
                        text:
                            'Ser la plataforma líder en diseño y distribución de planos de muebles de melamina en toda Latinoamérica.',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Valores
                Text(
                  'Nuestros Valores',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Wrap(
                  alignment: isMobile
                      ? WrapAlignment.center
                      : WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    _ValueChip(
                      icon: Icons.design_services_rounded,
                      label: 'Diseño con propósito',
                    ),
                    _ValueChip(
                      icon: Icons.handshake_rounded,
                      label: 'Compromiso y confianza',
                    ),
                    _ValueChip(
                      icon: Icons.lightbulb_rounded,
                      label: 'Innovación constante',
                    ),
                    _ValueChip(
                      icon: Icons.precision_manufacturing_rounded,
                      label: 'Precisión y calidad',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Card de misión / visión
class _MissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _MissionCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, color: kColorPrecio, size: 48),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// Chip de valor
class _ValueChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ValueChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      backgroundColor: kColorPrimario,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
