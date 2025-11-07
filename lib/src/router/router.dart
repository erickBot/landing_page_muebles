import 'package:fluro/fluro.dart';
import 'package:laning_page/src/router/router_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    // Rutas
    router.define('/:page', handler: homeHandler);
    router.define('/catalogo/muebles', handler: mueblesHandler);
    router.define('/catalogo/muebles/detail', handler: detailmuebleHandler);

    // 404
    router.notFoundHandler = homeHandler;
  }
}
