import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'providers/players_provider.dart';
import 'providers/ui_provider.dart';

import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black.withOpacity(0.25), // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
    systemNavigationBarDividerColor: Colors.transparent, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  runApp(const Init());
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Builder - Init');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayersProvider()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: MaterialApp(
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
