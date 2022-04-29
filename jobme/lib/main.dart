import 'package:flutter/material.dart';
import 'package:front/screens/home_screen.dart';
import 'package:front/screens/login_screen.dart';
import 'package:front/screens/profile_screen.dart';
import 'package:front/screens/register_screen.dart';
import 'package:front/screens/account_confirmation_screen.dart';
import 'package:front/screens/settings_screen.dart';
import 'package:front/screens/create_offer_screen.dart';
import 'package:front/screens/welcome_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:front/utils/local_storage.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const JobMe());
}

class JobMe extends StatelessWidget {
  const JobMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobMe',
      initialRoute: '/',
      routes: {
        '/': (_) => const WelcomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/account/confirmation': (_) => const AccountConfirmationScreen(),
        '/settings': (_) => const SettingScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/create/offer': (_) => const CreateOfferScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
