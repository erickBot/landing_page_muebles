import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nombreCtrl = TextEditingController();
    final TextEditingController _emailCtrl = TextEditingController();
    final TextEditingController _mensajeCtrl = TextEditingController();
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contáctanos',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '¿Tienes dudas o quieres un diseño personalizado? Escríbenos y te responderemos lo antes posible.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 40),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📨 Formulario
                Expanded(
                  flex: 2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreCtrl,
                          decoration: _inputDecoration('Nombre completo'),
                          validator: (v) => v == null || v.isEmpty
                              ? 'Ingrese su nombre'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: _inputDecoration('Correo electrónico'),
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Ingrese su correo';
                            if (!v.contains('@')) return 'Correo inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _mensajeCtrl,
                          decoration: _inputDecoration('Mensaje'),
                          maxLines: 5,
                          validator: (v) => v == null || v.isEmpty
                              ? 'Ingrese un mensaje'
                              : null,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Mensaje enviado correctamente',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              _nombreCtrl.clear();
                              _emailCtrl.clear();
                              _mensajeCtrl.clear();
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
                            backgroundColor: const Color(0xFFC62828),
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

                const SizedBox(width: 60),

                // 📞 Información de contacto y WhatsApp
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Información de contacto',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const _ContactInfoRow(
                        icon: Icons.email_rounded,
                        label: 'Correo:',
                        value: 'contacto@melaminapro.com',
                      ),
                      const _ContactInfoRow(
                        icon: Icons.location_on_rounded,
                        label: 'Ubicación:',
                        value: 'Lima, Perú',
                      ),
                      const _ContactInfoRow(
                        icon: Icons.access_time_rounded,
                        label: 'Atención:',
                        value: 'Lunes a Sábado, 9:00 a.m. - 6:00 p.m.',
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          const whatsappUrl =
                              'https://wa.me/51999999999?text=Hola%20MelaminaPro!%20Quiero%20más%20información%20sobre%20los%20planos.';
                          // Nota: para web, usa `html.window.open` (dart:html)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Abriendo WhatsApp...'),
                              duration: Duration(seconds: 2),
                            ),
                          );
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC62828), width: 2),
    ),
  );
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
        children: [
          Icon(icon, color: Color(0xFFC62828), size: 22),
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
