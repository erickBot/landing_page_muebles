import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/providers/product_provider.dart';
import 'package:laning_page/src/router/router.dart';
import 'package:laning_page/src/ui/pages/loading_page.dart';
import 'package:laning_page/src/ui/shared/custom_footer.dart';
import 'package:laning_page/src/ui/widgets/shimmer_network_image.dart';
import 'package:laning_page/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    return loading
        ? LoadingPage()
        : Scaffold(
            backgroundColor: const Color(0xFFF9F8FC),
            appBar: AppBar(
              backgroundColor: kColorFondo,
              elevation: 3,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Flurorouter.router.navigateTo(
                    context,
                    '/catalogo/muebles',
                    transition: TransitionType.fadeIn,
                  );
                },
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                // 🔍 Detecta tamaño de pantalla
                bool isMobile = constraints.maxWidth < 800;
                // bool isTablet =
                //     constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kColorFondo, // Lila muy suave
                        kColorFondoD,
                        kColorFondo,
                        // kColorPrimario, // Blanco para suavizar la parte inferior
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🧱 Sección principal: galería + detalle
                            Flex(
                              direction: isMobile
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 📸 Galería
                                Expanded(
                                  flex: isMobile ? 0 : 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 30,
                                      right: 30,
                                    ),
                                    child: const GaleriaMueble(),
                                  ),
                                ),

                                // 🧾 Detalle del producto
                                Expanded(
                                  flex: isMobile ? 0 : 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 0 : 20,
                                    ),
                                    child: const DetalleProducto(),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // 🧩 Características Principales
                            const CaracteristicasProducto(),
                            const SizedBox(height: 10),
                            const Dimensiones(),
                            const SizedBox(height: 10),
                            CustomFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

//
// 📸 Galería de imágenes (ejemplo simple)
//

class GaleriaMueble extends StatefulWidget {
  const GaleriaMueble({super.key});

  @override
  State<GaleriaMueble> createState() => _GaleriaMuebleState();
}

class _GaleriaMuebleState extends State<GaleriaMueble> {
  // 📷 Lista de imágenes
  final List<String> imagenes = [
    'assets/img/mueble_cocina.jpg',
    'assets/img/mueble_closet.png',
    'assets/img/mueble_escritorio.png',
    'assets/img/mueble_tv.png',
    'assets/img/mueble_comoda.png',
  ];

  int imagenSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).currentProduct;

    return Column(
      children: [
        // 🖼 Imagen principal
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: ClipRRect(
            key: ValueKey<String>(imagenes[imagenSeleccionada]),
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ShimmerNetworkImage(
                imageUrl: product.images![imagenSeleccionada],
                fit: BoxFit.contain,
                baseColor: kColorFondo,
                highlightColor: kColorFondoD,
                width: double.infinity,
                //height: isMobile ? 200 : 300,
              ),
              // child: FadeInImage(
              //   width: double.infinity,
              //   placeholder: AssetImage('assets/img/loading_image.gif'),
              //   image: NetworkImage(product.images![imagenSeleccionada]),
              //   fit: BoxFit.contain,
              // ),
              // child: Image.asset(
              //   imagenes[imagenSeleccionada],
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // 🖼 Miniaturas
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imagenes.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() => imagenSeleccionada = index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: index == imagenSeleccionada
                          ? kColorPrecio
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      if (index == imagenSeleccionada)
                        BoxShadow(
                          color: kColorFondo,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ShimmerNetworkImage(
                      imageUrl: product.images![index],
                      fit: BoxFit.cover,
                      baseColor: kColorFondo,
                      highlightColor: kColorPrimario,
                      width: 100,
                      height: 100,
                      //height: isMobile ? 200 : 300,
                    ),
                    // child: FadeInImage(
                    //   width: 100,
                    //   height: 100,
                    //   placeholder: AssetImage('assets/img/loading.gif'),
                    //   image: NetworkImage(product.images![index]),
                    //   fit: BoxFit.cover,
                    // ),
                    // child: Image.asset(
                    //   imagenes[index],
                    //   width: 100,
                    //   height: 100,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//
// 🧾 Detalle del producto (lado derecho)
//
class DetalleProducto extends StatelessWidget {
  const DetalleProducto({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).currentProduct;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${product.name}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: kColorTexto,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'ID: ${product.id}',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 15),
        Text(
          'Plano listo de enviar a corte',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Text(
          'USD ${product.price} ',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: kColorPrecio,
          ),
        ),
        const SizedBox(height: 24),

        // 🟣 Botón principal
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              final whatsapp = Provider.of<DataProvider>(
                context,
                listen: false,
              ).currentUtil.whatsapp;
              final whatsappUrl =
                  'https://wa.me/$whatsapp?text=Hola%20MelaminaPro!%20Quiero%20comprar%20este%20plano.';
              html.window.open(whatsappUrl, '_blank');
            },
            child: const Text(
              'Ir a comprar diseño →',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // ℹ️ Descripción corta
        const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.grey, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Recibirás todos los planos del mueble, listos para enviar al corte de melamina con total precisión.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.grey, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Te acompañamos en cada paso del proceso de armado del mueble.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//
// 🧾 Sección de características principales
//
class CaracteristicasProducto extends StatelessWidget {
  const CaracteristicasProducto({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).currentProduct;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Características Principales',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF222222),
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            children: [
              CaracteristicaItem(titulo: 'Material', valor: product.material!),
              CaracteristicaItem(
                titulo: 'Espesores disponibles',
                valor: product.espesor!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaracteristicaItem extends StatelessWidget {
  final String titulo;
  final String valor;

  const CaracteristicaItem({
    super.key,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check, color: kColorPrecio, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            Text(
              valor,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

//
// 🧾 Sección de características principales
//
class Dimensiones extends StatelessWidget {
  const Dimensiones({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medidas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF222222),
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            children: [
              CaracteristicaItem(titulo: 'Alto', valor: '240cm'),
              CaracteristicaItem(titulo: 'Ancho', valor: '180cm'),
              CaracteristicaItem(titulo: 'Profundidad', valor: '60cm'),
            ],
          ),
        ],
      ),
    );
  }
}
