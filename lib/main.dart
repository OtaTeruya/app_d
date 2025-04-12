import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'home/view/home.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF66CC66)),
        fontFamily: "Rounded",
        useMaterial3: true,
      ),
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', '')
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('en', '');
      },
      builder: (context, child) {
        return Title(
          title: AppLocalizations.of(context)?.title ?? '',
          color: Colors.black, // macOS/Windows のタスクバーで使われる色（指定必須なので）
          child: child!,
        );
      },
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
