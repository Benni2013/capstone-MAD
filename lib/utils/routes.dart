import 'package:flutter/material.dart';
import 'package:mad_final_project/pages/api/api_page.dart';
import 'package:mad_final_project/pages/details/detail_page.dart';
import 'package:mad_final_project/pages/home/home_page.dart';
import 'package:mad_final_project/pages/login/login_page.dart';
import 'package:mad_final_project/pages/notifications/notifications_page.dart';
import 'package:mad_final_project/pages/settings/settings_page.dart';
import 'package:mad_final_project/pages/signup/signup_page.dart';
import 'package:mad_final_project/models/property.dart';

import '../errors/exceptions.dart';
import '../pages/splash/splash_page.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String home = 'home';
  static const String details = 'details';
  static const String settings = 'settings';
  static const String notifications = 'notifications';
  static const String apiIntegration = 'api';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'details':
        final property = settings.arguments as Property;
        return MaterialPageRoute(builder: (_) => DetailsPage(property: property));
      case 'settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case 'notifications':
        return MaterialPageRoute(builder: (_) => NotificationsPage());
      case 'api':
        return MaterialPageRoute(builder: (_) => ApiIntegrationPage());
      default:
        throw RouteException('Route not found');
    }
  }
}