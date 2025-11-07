import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laning_page/src/models/product.dart';
import 'package:laning_page/src/providers/mueble_provider.dart';
import 'package:laning_page/src/providers/product_provider.dart';
import 'package:laning_page/src/router/router.dart';
import 'package:laning_page/src/ui/pages/loading_page.dart';
import 'package:laning_page/src/ui/widgets/shimmer_network_image.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';

class MueblesPage extends StatefulWidget {
  @override
  State<MueblesPage> createState() => _MueblesPageState();
}

class _MueblesPageState extends State<MueblesPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> productos = [
      {
        'nombre': 'Mueble de Cocina Moderna',
        'precio': 'USD 29.00',
        'imagen': 'assets/img/mueble_cocina.jpg',
        'descripcion':
            'Mueble de cocina moderna, fácil de armar. Incluye todos los planos para cortar y ensamblar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
      {
        'nombre': 'Closet Minimalista 3 Puertas',
        'precio': 'USD 25.00',
        'imagen': 'assets/img/mueble_closet.png',
        'descripcion':
            'Mueble de cocina moderna, fácil de armar. Incluye todos los planos para cortar y ensamblar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
      {
        'nombre': 'Escritorio de Oficina Compacto',
        'precio': 'USD 19.00',
        'imagen': 'assets/img/mueble_escritorio.png',
        'descripcion':
            'Mueble de cocina moderna, fácil de armar. Incluye todos los planos para cortar y ensamblar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
      {
        'nombre': 'Centro de Entretenimiento TV',
        'precio': 'USD 35.00',
        'imagen': 'assets/img/mueble_tv.png',
        'descripcion':
            'Mueble de cocina moderna, fácil de armar. Incluye todos los planos para cortar y ensamblar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
      {
        'nombre': 'Comoda con 4 Cajones',
        'precio': 'USD 22.00',
        'imagen': 'assets/img/mueble_comoda.png',
        'descripcion':
            'Mueble de cocina moderna, fácil de armar. Incluye todos los planos para cortar y ensamblar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
      {
        'nombre': 'Mesa de Noche Moderna',
        'precio': 'USD 15.00',
        'imagen': 'assets/img/mueble_mesita.png',
        'descripcion': 'Mueble de cocina moderna, fácil de armar.',
        'dimensiones': '240 X 180 X 60 cm',
      },
    ];

    return Consumer<MuebleProvider>(
      builder: (context, value, child) => loading
          ? LoadingPage()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: kColorFondo,
                elevation: 3,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Flurorouter.router.navigateTo(
                      context,
                      '/catalogo',
                      transition: TransitionType.fadeIn,
                    );
                  },
                ),
                title: Text(
                  '${value.currentMueble.name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descubre nuestros diseños listos para fabricar. Cada plano está optimizado para un corte preciso y eficiente.',
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.black,
                          fontSize: 18,
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
                            itemCount: value.currentProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1.1,
                                ),
                            itemBuilder: (context, index) {
                              Product producto = value.currentProducts[index];
                              return _ProductCard(product: producto);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Product product;

  const _ProductCard({required this.product});

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
        child: GestureDetector(
          onTap: () {
            final productProvider = Provider.of<ProductProvider>(
              context,
              listen: false,
            );
            productProvider.setProduct(widget.product);
            Flurorouter.router.navigateTo(
              context,
              '/catalogo/muebles/detail',
              transition: TransitionType.fadeIn,
            );
          },
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
                    imageUrl: widget.product.images![0],
                    fit: BoxFit.cover,
                    baseColor: kColorFondo,
                    highlightColor: kColorPrimario,
                    width: double.infinity,
                    //height: isMobile ? 200 : 300,
                  ),
                  // child: FadeInImage(
                  //   width: double.infinity,
                  //   placeholder: AssetImage('assets/img/loading_image.gif'),
                  //   image: NetworkImage(widget.product.images![0]),
                  //   fit: BoxFit.cover,
                  // ),
                  // child: Image.asset(
                  //   widget.product.images![0],
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
                        widget.product.name!,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.product.description!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kColorAcento,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Dimensiones: ${widget.product.largo} X ${widget.product.ancho} X ${widget.product.profundidad}',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'USD ${widget.product.price}',
                            style: TextStyle(
                              fontSize: 20,
                              // color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              foreground: Paint()
                                ..style = PaintingStyle.fill
                                ..strokeWidth =
                                    1.5 // 🔹 aumenta para hacerlo más grueso visualmente
                                ..color = kColorPrecio,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Saber más ',
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
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
