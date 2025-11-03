import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sobre Nosotros',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Transformamos la forma en que se diseñan y fabrican los muebles de melamina.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Sección de historia + imagen
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nuestra Historia',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'MelaminaPro nació con la misión de ayudar a carpinteros, diseñadores y aficionados a convertir sus ideas '
                        'en proyectos reales. Nos especializamos en la creación de planos de muebles de melamina listos para fabricar, '
                        'con medidas exactas, instrucciones claras y diseños modernos.',
                        style: TextStyle(fontSize: 16, height: 1.6),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'A lo largo del tiempo, hemos trabajado con profesionales del rubro para optimizar cada diseño, garantizando '
                        'el máximo aprovechamiento del material y la compatibilidad con software de corte CNC.',
                        style: TextStyle(fontSize: 16, height: 1.6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                // Imagen decorativa
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image.asset(
                      'assets/img/nosotros_taller.png',
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // Misión y visión
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _MissionCard(
                  icon: Icons.flag_rounded,
                  title: 'Nuestra Misión',
                  text:
                      'Facilitar el acceso a planos profesionales y precisos de muebles de melamina, impulsando el crecimiento de carpinteros y emprendedores.',
                ),
                _MissionCard(
                  icon: Icons.remove_red_eye_rounded,
                  title: 'Nuestra Visión',
                  text:
                      'Ser la plataforma líder en diseño y distribución de planos de muebles de melamina en toda Latinoamérica.',
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Valores
            const Text(
              'Nuestros Valores',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Wrap(
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
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(icon, color: Color(0xFFC62828), size: 48),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
      backgroundColor: const Color(0xFFC62828),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
