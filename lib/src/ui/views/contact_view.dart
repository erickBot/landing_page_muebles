import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/services/message_service.dart';
import 'package:laning_page/src/ui/widgets/message.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();

  static InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    labelStyle: GoogleFonts.lato(color: kColorTexto),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kColorPrimario, width: 2),
    ),
  );
}

class _ContactViewState extends State<ContactView> {
  List<Map<String, dynamic>> redesSociales = [
    {
      'icon': FontAwesomeIcons.youtube,
      'url': 'https://www.facebook.com/erick.pasache.7',
    },
    {
      'icon': FontAwesomeIcons.tiktok,
      'url': 'https://www.facebook.com/erick.pasache.7',
    },
    {
      'icon': FontAwesomeIcons.instagram,
      'url': 'https://www.facebook.com/erick.pasache.7',
    },
    {
      'icon': FontAwesomeIcons.facebook,
      'url': 'https://www.facebook.com/erick.pasache.7',
    },
  ];

  final formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mensajeCtrl = TextEditingController();

  MessageService messageService = MessageService();

  bool isHover = false;

  @override
  void initState() {
    super.initState();
    messageService.init(context);
  }

  void sendMessage() async {
    try {
      String nombre = nombreCtrl.text;
      String email = emailCtrl.text;
      String message = mensajeCtrl.text;

      if (nombre.isEmpty && email.isEmpty && message.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Los campos son obligatorios'),
              backgroundColor: kColorPrimario,
              duration: Duration(seconds: 5),
            ),
          );
        });

        return;
      }

      final res = await messageService.sendMessage(nombre, email, message);

      if (res!.success!) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res.msg!),
              backgroundColor: kColorPrimario,
              duration: Duration(seconds: 5),
            ),
          );
        });

        nombreCtrl.clear();
        emailCtrl.clear();
        mensajeCtrl.clear();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res.msg!),
              backgroundColor: kColorPrimario,
              duration: Duration(seconds: 5),
            ),
          );
        });

        return;
      }
    } catch (err) {
      print(err);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;

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
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 60,
              vertical: isMobile ? 30 : 40,
            ),
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  'Contáctanos',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ),
                const SizedBox(height: 10),
                Text(
                  '¿Tienes dudas o quieres un diseño personalizado? Escríbenos y te responderemos lo antes posible.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: isMobile ? 14 : 16,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ),
                const SizedBox(height: 40),

                // 🧩 FORM + INFO
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 📨 Formulario
                    Expanded(
                      flex: isMobile ? 0 : 2,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nombreCtrl,
                              decoration: ContactView._inputDecoration(
                                'Nombre completo',
                              ),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese su nombre'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: emailCtrl,
                              decoration: ContactView._inputDecoration(
                                'Correo electrónico',
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese su correo';
                                }
                                if (!v.contains('@')) return 'Correo inválido';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: mensajeCtrl,
                              decoration: ContactView._inputDecoration(
                                'Mensaje',
                              ),
                              maxLines: 5,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese un mensaje'
                                  : null,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  sendMessage();
                                }
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Enviar mensaje',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kColorPrimario,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      width: isMobile ? 0 : 60,
                      height: isMobile ? 40 : 0,
                    ),

                    // 📞 Información de contacto y WhatsApp
                    Consumer<DataProvider>(
                      builder: (context, value, child) => Expanded(
                        flex: isMobile ? 0 : 1,
                        child: Column(
                          crossAxisAlignment: isMobile
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Información de contacto',
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _ContactInfoRow(
                              icon: Icons.email_rounded,
                              label: 'Correo:',
                              value: value.currentUtil.email!,
                            ),
                            _ContactInfoRow(
                              icon: Icons.location_on_rounded,
                              label: 'Ubicación:',
                              value: value.currentUtil.address!,
                            ),
                            const _ContactInfoRow(
                              icon: Icons.access_time_rounded,
                              label: 'Atención:',
                              value: 'Lunes a Sábado, 9:00 a.m. - 6:00 p.m.',
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: redesSociales
                                  .map(
                                    (element) => IconButton(
                                      onPressed: () {
                                        final social = element['url'];
                                        html.window.open(social, '_blank');
                                      },
                                      hoverColor: kColorAcento,
                                      icon: Icon(
                                        element['icon'],
                                        color: kColorTexto,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton.icon(
                              onPressed: () {
                                final whatsapp = value.currentUtil.whatsapp!;
                                final whatsappUrl =
                                    'https://wa.me/$whatsapp?text=Hola%20MelaminaPro!%20Quiero%20más%20información%20sobre%20los%20planos.';
                                html.window.open(whatsappUrl, '_blank');
                              },
                              icon: const Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Escribir por WhatsApp',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

// Widget para mostrar íconos + texto
class _ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: kColorPrimario, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label ',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
