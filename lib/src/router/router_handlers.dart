import 'package:fluro/fluro.dart';
import 'package:laning_page/src/providers/page_provider.dart';
import 'package:laning_page/src/ui/pages/detail_page.dart';
import 'package:laning_page/src/ui/pages/home_page.dart';
import 'package:laning_page/src/ui/pages/muebles_page.dart';
import 'package:provider/provider.dart';

final homeHandler = Handler(
  handlerFunc: (context, params) {
    final page = params['page']!.first;
    if (page != '/') {
      final pageProvider = Provider.of<PageProvider>(context!, listen: false);
      pageProvider.createScrollController(page);

      return HomePage();
    }
  },
);

final mueblesHandler = Handler(
  handlerFunc: (context, params) {
    return MueblesPage(); // Página independiente
  },
);

final detailmuebleHandler = Handler(
  handlerFunc: (context, params) {
    return DetailPage(); // Página independiente
  },
);
