// @dart=2.9
// ignore_for_file: missing_return

import 'dart:io';
import 'package:air_camel/main_controller.dart';
import 'package:air_camel/providers/credit_payments_provider.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_profile.dart';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/filters_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/new_shipment_menu_screen.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/trip_detail_screen.dart';
import 'package:air_camel/pages/company/complaints_screen.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/pages/launch_app/login_screen.txt';
import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/credit_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/providers/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AccountsProvider()),
          ChangeNotifierProvider(create: (ctx) => NotificationsProvider()),
          ChangeNotifierProvider(create: (ctx) => CreditPaymentsProvider()),
        ],
        child: MaterialApp(
          title: 'AirCamel',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.amber.shade600,
            primarySwatch: Colors.amber,
          ),

          home: MainController(),
      
          routes: {
            FiltersScreen.routeName: (ctx) => FiltersScreen(),
            ClientNavigationScreen.routeName: (ctx) => ClientNavigationScreen(),
            NewShipmentMenu.routeName: (ctx) => NewShipmentMenu(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            TripDetailsScreen.routeName: (ctx) => TripDetailsScreen(),
            CompanyNavigationScreen.routeName: (ctx) =>
                CompanyNavigationScreen(),
            HelpScreen.routeName: (ctx) => HelpScreen(),
            AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
            CreditScreen.routeName: (ctx) => CreditScreen(),
            OffersScreen.routeName: (ctx) => OffersScreen(),
            InviteScreen.routeName: (ctx) => InviteScreen(),
            EditCategories.routeName: (ctx) => EditCategories(),
            ComplaintsScreen.routeName: (ctx) => ComplaintsScreen(),
            PayementsHistory.routeName: (ctx) => PayementsHistory(),
            EditProfileScreen.routeName: (ctx) => EditProfileScreen()
          },
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
