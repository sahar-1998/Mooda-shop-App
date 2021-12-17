import 'package:Modda_shop/screens/auth/signup_screen.dart';
import 'package:Modda_shop/screens/auth/exploreus_screen.dart';
import 'package:Modda_shop/screens/auth/forget_password_screen.dart';
import 'package:Modda_shop/screens/auth/launch.dart';
import 'package:Modda_shop/screens/auth/on_boarding.dart';
import 'package:Modda_shop/screens/auth/signin_screen.dart';
import 'package:Modda_shop/screens/bn_screens/categories_screen.dart';
import 'package:Modda_shop/screens/bn_screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Modda_shop/prefs/shared_pref_controller.dart';
import 'package:Modda_shop/screens/bn_screens/home_screen.dart';
import 'package:Modda_shop/screens/main_screen.dart';
import 'package:Modda_shop/screens/profile/faq.dart';
import 'package:Modda_shop/screens/profile/contact_request.dart';
import 'package:Modda_shop/screens/profile/personal_info.dart';
import 'package:Modda_shop/screens/profile/settings.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch_screen',
        //initialRoute: '/verify_code',
        routes: {
          /*    AUTH SCREENS     */
          '/launch_screen': (context) => LaunchScreen(),
          '/OnBoarding': (context) => OnBoarding(),
          '/Explore_screen': (context) => Explore(),
          '/Sign_in': (context) => SignIn(),
          '/create_account': (context) => CreateAccount(),
          '/forget_password': (context) => ForgetPassword(),
          //'verify_code'  :(context)=> / VerifyCode(),
          '/home_screen': (context) => Home(),
          '/main_screen': (context) => MainScreen(),
          '/personal_info': (context) => PersonalInfo(),
          '/settings': (context) => Settings(),
          '/faq': (context) => FAQ(),
          '/contact_request': (context) => ContactRequest(),
         // '/products_screen': (context) => ProductsScreen(),
          '/categories_screen': (context) => CategoriesScreen(),
        // '/product_details': (context) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
