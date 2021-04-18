import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:logger/logger.dart';
import 'package:payment_gateway/constants/constants.dart';
import 'package:payment_gateway/router/router.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/theme/dynamic_theme.dart';
import 'package:payment_gateway/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<DynamicTheme>(
      create: (_) => DynamicTheme(),
      child: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);

    if (Constants.isNeu) {
      return NeumorphicApp(
        debugShowCheckedModeBanner: Constants.debugShowCheckedModeBanner,
        themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: themeProvider.isDarkMode
            ? MyTheme.instance.getDarkTheme()
            : MyTheme.instance.getLightTheme(),
        darkTheme: MyTheme.instance.getDarkTheme(),
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          minWidth: 380,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        ),
        home: HomePage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: Constants.debugShowCheckedModeBanner,
        theme: themeProvider.isDarkMode
            ? MyTheme.instance.getDarkTheme()
            : MyTheme.instance.getLightTheme(),
        onGenerateRoute: AppRouter.generateRoute,
        home: HomePage(),
        initialRoute: '/homePage',
      );
    }
  }
}

/*
 if (kIsWeb)
                  PaymentUtil.instance.makeWebPayment(
                    PaymentModel(
                      customerEmail: 'gs@gmail.com',
                      customerName: 'Gangadhara',
                      customerPhone: '919916548851',
                      orderAmount: '1',
                      orderNote: 'Note note',
                      stage: PaymentMode.prod,
                    ).toJsonString(),
                  );
 */
