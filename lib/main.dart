import 'package:flutter/services.dart';
import 'package:cinema_db/providers/watch_list_provider.dart';
import 'package:cinema_db/providers/watch_detail_provider.dart';
import 'package:cinema_db/providers/search_watch_provider.dart';
import 'package:cinema_db/routes/go_router.dart';
import 'package:cinema_db/theme_data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WatchListProvider()),
        ChangeNotifierProvider(create: (context) => SearchWatchProvider()),
        ChangeNotifierProvider(create: (context) => WatchDetailProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cinema DB',
      theme: themeData(),
      routerConfig: router,
    );
  }
}
