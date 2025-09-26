import 'package:flutter/material.dart';
import 'package:plasfora_app/pages/specialties/plastic_surgery.dart';
import 'widgets/auth_screen.dart';
import 'pages/services/medical_booking.dart';
import 'pages/services/travel_assisant.dart';
import 'pages/contact_us.dart';
import 'pages/resources/visit_tunisia.dart';
import 'pages/profile.dart';
import 'package:plasfora_app/pages/acceuil.dart';
import 'pages/main_layout.dart';
import '../pages/chat.dart' as chat_page;
import 'package:plasfora_app/widgets/map.dart' as map_widget;
import 'pages/specialties/dentistry.dart';
import 'pages/specialties/hair_transplant.dart';
import 'pages/specialties/ivf.dart';
import 'pages/specialties/healthy_holiday.dart';
import 'pages/specialties/general_treatment.dart';
import 'package:plasfora_app/pages/process.dart' as process;
import '../pages/viewProfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryBlue = Color.fromARGB(255, 62, 101, 240);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: primaryBlue,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryBlue),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryBlue),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          labelStyle: TextStyle(color: primaryBlue),
          hintStyle: TextStyle(color: primaryBlue.withOpacity(0.7)),
        ),
      ),

      // AuthScreen affiché sans layout
      home: AuthScreen(),

      routes: {
        // Bottom nav pages
        '/home': (context) => MainLayout(
          title: 'Home',
          bottomNavIndex: 0,
          child: PlasforaHomeScreen(),
        ),
        '/chat': (context) => MainLayout(
          title: 'Chat',
          bottomNavIndex: 1,
          child: chat_page.ChatPage(), // utilise l'alias
        ),

        '/map': (context) => MainLayout(
          title: 'Map',
          bottomNavIndex: 2,
          child: map_widget.MapPage(), // utilise l'alias
        ),

        '/profile': (context) => const MainLayout(
          title: 'Profile',
          bottomNavIndex: 3,
          child: ProfilePage(),
        ),

        // Specialty pages
        '/plastic_surgery': (context) =>
            MainLayout(title: 'Plastic Surgery', child: PlasticSurgeryPage()),
        '/dentistry': (context) =>
            MainLayout(title: 'Dentistry', child: DentistryPage()),
        '/hair_transplant': (context) =>
            MainLayout(title: 'Hair Transplant', child: HairTransplantPage()),
        '/ivf': (context) => const MainLayout(title: 'IVF', child: IVFPage()),
        '/healthy_holiday': (context) =>
            MainLayout(title: 'Healthy Holiday', child: HealthyHolidayPage()),
        '/general_treatment': (context) => MainLayout(
          title: 'GeneralTreatment',
          child: GeneralTreatmentPage(),
        ),

        // Services
        '/medical_booking': (context) =>
            const MainLayout(title: 'Medical Booking', child: BookingPage()),

        '/travel_assistance': (context) => const MainLayout(
          title: 'Travel Assistance',
          child: TravelAssistancePage(),
        ),

        // Resources
        '/visit_tunisia': (context) =>
            const MainLayout(title: 'Visit Tunisia', child: VisitTunisiaPage()),
        '/contact_us': (context) =>
            const MainLayout(title: 'Contact Us', child: ContactUsPage()),

        // Process
        '/process': (context) =>
            MainLayout(title: 'Process', child: process.ProcessPage()),

        // Logout
        '/auth_screen': (context) => AuthScreen(),

        //Profile
        '/viewProfile': (context) =>
            const MainLayout(title: 'View Profile', child: ViewProfilePage()),
      },
    );
  }
}
