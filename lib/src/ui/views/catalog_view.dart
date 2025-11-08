import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laning_page/src/models/mueble.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/providers/mueble_provider.dart';
import 'package:laning_page/src/router/router.dart';
import 'package:laning_page/src/ui/widgets/shimmer_network_image.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';

class CatalogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catálogo de Planos',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Descubre nuestros diseños listos para fabricar. Cada plano está optimizado para un corte preciso y eficiente.',
              style: GoogleFonts.lato(
                color: Color(0xFF6B7280), // Gris azulado suave
                fontWeight: FontWeight.w400,
                height: 1.6,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Consumer<DataProvider>(
              builder: (context, value, child) => LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 900) crossAxisCount = 2;
                  if (constraints.maxWidth < 600) crossAxisCount = 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.currentMuebles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      final mueble = value.currentMuebles[index];
                      return _ProductCard(mueble: mueble);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Mueble mueble;

  const _ProductCard({required this.mueble});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: isHover
            ? Matrix4.identity().scaled(1.05)
            : Matrix4.identity(), // zoom suave
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHover
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 200, 196, 196),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Card(
          elevation: 4,
          color: isHover ? kColorFondo : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del mueble
              Expanded(
                child: ShimmerNetworkImage(
                  imageUrl: widget.mueble.imageUrl!,
                  fit: BoxFit.cover,
                  baseColor: kColorFondo,
                  highlightColor: kColorFondoD,
                  width: double.infinity,
                  //height: isMobile ? 200 : 300,
                ),
                // child: FadeInImage(
                //   width: double.infinity,
                //   placeholder: AssetImage('assets/img/loading_image.gif'),
                //   image: NetworkImage(widget.mueble.imageUrl!),
                //   fit: BoxFit.cover,
                // ),
                // child: Image.asset(
                //   widget.imagen,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                // ),
              ),

              // Detalles
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mueble.name!,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Text(
                    //   'Desde ${widget.precio}',
                    //   style: const TextStyle(
                    //     fontSize: 22,
                    //     color: Colors.black45,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        //actualiza el provider
                        final muebleProvider = Provider.of<MuebleProvider>(
                          context,
                          listen: false,
                        );
                        muebleProvider.init(context, widget.mueble.id!);
                        muebleProvider.setMueble(widget.mueble);
                        //
                        Flurorouter.router.navigateTo(
                          context,
                          '/catalogo/muebles',
                          transition: TransitionType.fadeIn,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorPrimario,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Ver más',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
