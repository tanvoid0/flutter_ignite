import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ignite/data/theme_config_options.dart';
import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utils/web_drag_scroll_behavior.dart';

class FlutterIgnite {
  final String version = "v0.2.6.1";
  static String _title = "";

  static String get title => _title;

  static bool _logToFile = false;

  static bool get logToFile => _logToFile;

  static bool _cacheReset = false;

  static bool get cacheReset => _cacheReset;

  static Dio _dio = Dio();

  static Dio get dio => _dio;

  FlutterIgnite(
      {String title = "FlutterIgnite",
      logToFile = false,
      cacheReset = false,
      final BaseOptions? dioOptions}) {
    if (_instance != null) {
      return;
    }
    _instance = this;
    _title = title;
    _logToFile = logToFile;
    _cacheReset = cacheReset;
    _dio = Dio(dioOptions);
    // _dio.interceptors.add(DioErrorHandler());
  }

  Future<CacheService> initConfigs({
    required ThemeConfigOptions themeConfig,
    final List<Serializable> cacheItems = const [],
  }) async {
    Pen.write(
        "$title app configuration started in ${kDebugMode ? "Debug" : "Production"} mode");
    final cacheService =
        await Get.putAsync(() => CacheService().init(items: cacheItems));
    final configService = Get.put<ConfigService>(ConfigService(cacheService));
    Get.put<ThemeService>(
        ThemeService(configService: configService, config: themeConfig));
    Get.put<ConnectivityService>(ConnectivityService());
    return cacheService;
  }

  void initServices(final List<GetxService> services) {
    Pen.log("Getx Service configuration initiated");
    for (final GetxService service in services) {
      Get.put<GetxService>(service, permanent: true);
      Pen.success("Getx service initialized: ${service.runtimeType}");
    }
  }

  void initServicesFunc(final Function fn) {
    fn();
  }

  static FlutterIgnite? _instance;

  // run({bool guarded = true,
  //   required List<GetPage> pages,
  //   required String initialRoute,
  //   SmartManagement managementFactory = SmartManagement.keepFactory}) {
  //
  //   if (guarded) {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     runZonedGuarded(
  //             () =>
  //             runApp(app(
  //                 initialRoute: initialRoute,
  //                 pages: pages,
  //                 managementFactory: managementFactory)), handleError);
  //   }
  //   else {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     runApp(app(
  //         initialRoute: initialRoute,
  //         pages: pages,
  //         managementFactory: managementFactory));
  //   }
  // }

  app(
      {required String initialRoute,
      required List<GetPage> pages,
      SmartManagement managementFactory = SmartManagement.keepFactory}) {
    final themeService = Get.find<ThemeService>();
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: themeService.lightTheme(),
          darkTheme: themeService.darkTheme(),
          themeMode: themeService.themeMode(),
          smartManagement: managementFactory,
          initialRoute: initialRoute,
          getPages: pages,
          builder: (context, child) =>
              ResponsiveBreakpoints.builder(child: child!, breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K')
          ]),
          scrollBehavior: WebDragScrollBehavior(),
        ));
  }
}
