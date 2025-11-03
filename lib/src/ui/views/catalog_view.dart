import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> productos = [
      {
        'nombre': 'Mueble de Cocina Moderna',
        'precio': 'USD 29.00',
        'imagen': 'assets/img/mueble_cocina.jpg',
      },
      {
        'nombre': 'Closet Minimalista 3 Puertas',
        'precio': 'USD 25.00',
        'imagen': 'assets/img/mueble_closet.png',
      },
      {
        'nombre': 'Escritorio de Oficina Compacto',
        'precio': 'USD 19.00',
        'imagen': 'assets/img/mueble_escritorio.png',
      },
      {
        'nombre': 'Centro de Entretenimiento TV',
        'precio': 'USD 35.00',
        'imagen': 'assets/img/mueble_tv.png',
      },
      {
        'nombre': 'Comoda con 4 Cajones',
        'precio': 'USD 22.00',
        'imagen': 'assets/img/mueble_comoda.png',
      },
      {
        'nombre': 'Mesa de Noche Moderna',
        'precio': 'USD 15.00',
        'imagen': 'assets/img/mueble_mesita.png',
      },
    ];

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catálogo de Planos',
              style: GoogleFonts.montserratAlternates(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Descubre nuestros diseños listos para fabricar. Cada plano está optimizado para un corte preciso y eficiente.',
              style: GoogleFonts.montserratAlternates(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 3;
                if (constraints.maxWidth < 900) crossAxisCount = 2;
                if (constraints.maxWidth < 600) crossAxisCount = 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return _ProductCard(
                      nombre: producto['nombre']!,
                      precio: producto['precio']!,
                      imagen: producto['imagen']!,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String nombre;
  final String precio;
  final String imagen;

  const _ProductCard({
    required this.nombre,
    required this.precio,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    void mostrarDetalles(
      BuildContext context,
      String nombre,
      String precio,
      String imagen,
    ) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 100, height: 100, child: Image.asset(imagen)),
                const SizedBox(height: 12),
                // Text(mueble['descripcion']!, textAlign: TextAlign.center),
                // const SizedBox(height: 12),
                Text(
                  'Precio: $precio',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                ),
                label: const Text(
                  'Contactar por WhatsApp',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  final String telefono = '+51958445422'; // tu número
                  final String mensaje =
                      'Hola, estoy interesado en el $nombre ($precio). ¿Podrías darme más información?';
                  final String url =
                      'https://wa.me/$telefono?text=${Uri.encodeComponent(mensaje)}';
                  launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del mueble
          Expanded(
            child: Image.asset(
              imagen,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Detalles
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  precio,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      mostrarDetalles(context, nombre, precio, imagen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ver Detalles',
                    style: GoogleFonts.lato(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
