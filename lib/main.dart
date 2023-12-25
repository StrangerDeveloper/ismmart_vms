import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/create_payout/create_payout_view.dart';
import 'package:ismmart_vms/screens/dashboard/dashboard_view.dart';

import 'firebase_options.dart';
import 'helper/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISMMART VMS',
      theme: ThemeData(
        primarySwatch: ThemeHelper.plattet1,
        useMaterial3: false,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: GoogleFonts.dmSerifDisplay(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            centerTitle: true,
            elevation: 3,
            shadowColor: Colors.black12),
      ),
      home: DashboardView(),
      initialRoute: Routes.initRoute,
      getPages: Routes.pages,
    );
  }
}
