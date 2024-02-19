import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Blocs/localizationCubit/localization_cubit.dart';
import 'package:graduation_project_end_user/Views/Splash%20Screan/splash.dart';

import '../Views/MainScrean/View/main_Screen.dart';
import '../generated/l10n.dart';
import '../utils/thems.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MultiBlocProvider(providers: [

          BlocProvider(create: (context) => LocalizationCubit()..getCurrentLang()),
        ], child: Builder(
          builder: (context) {
             LocalizationCubit.get(context).getCurrentLang();
            final getlocale = LocalizationCubit.get(context).lang;
            final getCountrCode = LocalizationCubit.get(context).countryCode;

            return MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(getlocale!,getCountrCode!),
              debugShowCheckedModeBanner: false,

              // You can use the library anywhere in the app even in theme
              theme: lightTheme,
              home: child,
            );
          }
        ));
      },
      child:SecondClass(),
    );
  }
}