import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_tutorial_flutter/core/common/app/providers/user_provider.dart';
import 'package:tdd_tutorial_flutter/core/res/colors.dart';
import 'package:tdd_tutorial_flutter/core/res/fonts.dart';
import 'package:tdd_tutorial_flutter/core/services/injection_container.dart';
import 'package:tdd_tutorial_flutter/core/services/router.dart';
import 'package:tdd_tutorial_flutter/firebase_options.dart';
import 'package:tdd_tutorial_flutter/src/dashboard/presentation/views/providers/dashboard_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider(),),
        ChangeNotifierProvider(create: (_)=> DashboardController(),),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        ),
        onGenerateRoute: generateRoute,
        // home: const HomeScreen(),
      ),
    );
  }
}
