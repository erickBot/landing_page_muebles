import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _authorSection(),
                const SizedBox(height: 40),
                _contactSection(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _authorSection()),
                Expanded(child: _contactSection()),
              ],
            ),
    );
  }

  Widget _authorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu mueble',
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: kColorTexto,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Tu talento merece planos profesionales. Da el siguiente paso con TuMueble.com.',
          style: GoogleFonts.lato(
            fontSize: 18,
            height: 1.6,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 30),
        _contactButton(),
      ],
    );
  }

  Widget _contactButton() {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.5, color: const Color(0xFF8A70D6)),
          gradient: const LinearGradient(
            colors: [Color(0xFF8A70D6), Color(0xFFB98EF3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            final whatsapp = value.currentUtil.whatsapp;
            final whatsappUrl =
                'https://wa.me/$whatsapp?text=Hola%20MelaminaPro!%20Quiero%20más%20información%20sobre%20los%20planos.';
            html.window.open(whatsappUrl, '_blank');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Contáctame',
                  style: GoogleFonts.montserratAlternates(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_right_alt_rounded,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactSection() {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contacto',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kColorTexto,
            ),
          ),
          const SizedBox(height: 20),
          _contactText('E-mail de contacto:', value.currentUtil.email!),
          const SizedBox(height: 10),
          _contactText('Whatsapp:', value.currentUtil.whatsapp!),
          const SizedBox(height: 10),
          _contactText('Ubicación:', value.currentUtil.address!),
          const SizedBox(height: 30),
          _socialIcons(),
        ],
      ),
    );
  }

  Widget _contactText(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcons() {
    final url_tiktok = 'https://www.tiktok.com/@tu_mueble.oficial';
    final utl_instagram = 'https://www.instagram.com/tumueble.oficial/';
    final url_youtube =
        'https://www.youtube.com/channel/UCa8QejxhW_NoiYxqjgmEEuA';
    return Row(
      children: [
        IconButton(
          hoverColor: kColorFondo,
          onPressed: () {
            html.window.open(url_tiktok, '_blank');
          },
          icon: Icon(FontAwesomeIcons.tiktok, color: Colors.grey, size: 20),
        ),
        SizedBox(width: 18),
        IconButton(
          hoverColor: kColorFondo,
          onPressed: () {
            html.window.open(url_youtube, '_blank');
          },
          icon: Icon(FontAwesomeIcons.youtube, color: Colors.grey, size: 20),
        ),
        SizedBox(width: 18),
        IconButton(
          hoverColor: kColorFondo,
          onPressed: () {
            html.window.open(utl_instagram, '_blank');
          },
          icon: Icon(FontAwesomeIcons.instagram, color: Colors.grey, size: 20),
        ),
        SizedBox(width: 18),
      ],
    );
  }
}
