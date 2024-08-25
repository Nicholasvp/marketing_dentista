import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';
import 'package:marketing_dentista/core/utils/app_routes.dart';
import 'package:marketing_dentista/features/home/views/home_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const HomeView(),
      routes: AppRoutes.routes,
    );
  }
}
