import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stores_app/View/NewOrder.dart';
import 'package:stores_app/View/SaleInv.dart';
import 'Controller/ProductService.dart';
import 'View/Auth.dart';
import 'View/Home.dart';
import 'View/Product_detail.dart';
import 'View/cart.dart';
import 'app_localizations.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    final Locale locale = Locale('ar');
    runApp( MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.lightGreen,
            accentColor: Colors.lightBlue[900],
            fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato'),
        supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'JO'),
        ],
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
        ],
        //supportedLocale.countryCode == locale.countryCode
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
                print("supportedLocale 1= $supportedLocale");
                print("supportedLocale 2= ${locale.countryCode}");
                if (supportedLocale.languageCode == locale.languageCode ) {
                    print("supportedLocale 2= $supportedLocale");
                    print("supportedLocale languageCode = ${supportedLocale.languageCode}");
                    ProductService.language = supportedLocale.languageCode;
                    return supportedLocale;
                }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
        },
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => Auth(),
            '/home': (BuildContext context) => Home(),
            '/salesInv': (BuildContext context) => SaleInv(),
            '/newOrder': (BuildContext context) => NewOrder(),
            '/productDetails': (BuildContext context) => ProductDetails.c(),
            '/cart': (BuildContext context) => CartList(),
        },
      ),
    );
}
