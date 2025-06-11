import 'package:chatapp/Chat_Screen/ChatScreen.dart';
import 'package:chatapp/modules/CommunityScreen.dart';
import 'package:chatapp/modules/Login/LoginScreen.dart';
import 'package:chatapp/modules/Login/RegisterScreen.dart';
import 'package:chatapp/modules/ProfileScreen.dart';
import 'package:chatapp/modules/ReportsScreen.dart';
import 'package:chatapp/modules/SettingsScreen.dart';
import 'package:chatapp/modules/UploadImageScreen.dart';
import 'package:chatapp/shared/components/CarouselWithDotsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'helpers/ColorsSys.dart';
import 'modules/ChatBotScreen.dart';
import 'modules/DiseaseLibraryScreen.dart';
import 'modules/Login/HomeScreen.dart';
import 'modules/Login/onboarding_screen.dart';
import 'modules/WeatherScreen.dart';
import 'modules/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        /*  theme:ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor:Colors.white,
                appBarTheme:AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarBrightness: Brightness.dark,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange
                )
            ),*/
        scaffoldBackgroundColor: ColorSys.five,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorSys.five,
          onPrimary: Colors.black,
          secondary: Colors.red,
          onSecondary: Colors.black,
          onBackground: Colors.black,
          surface: Colors.white70,
          onSurface: Colors.black,
          error: Colors.red,       // error background color (red)
          onError: Colors.black,   // error text color (black)
        ),

      ),
     // home: CarouselWithDotsPage(imgList: ['https://static.vecteezy.com/system/resources/thumbnails/036/324/708/small/ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg','https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg'],), //
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScren.id: (context) => ChatScren(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        UploadImageScreen.id: (context) => UploadImageScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ReportsScreen.id: (context) => ReportsScreen(),
        CommunityScreen.id: (context) => CommunityScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        DiseaseLibraryScreen.id: (context) => DiseaseLibraryScreen(),
        ChatBotScreen.id: (context) => ChatBotScreen(), // Register here
        WeatherScreen.id: (context) => const WeatherScreen(),



      },

 initialRoute: SplashScreen.id
    );
  }
}
