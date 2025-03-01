import 'package:zubair_onward_academy/view/lecturesData/lectures_screen.dart';
import 'package:zubair_onward_academy/view/mcqsData/mcqs_screen.dart';
import 'package:zubair_onward_academy/view/notesData/notes_screen.dart';
import 'package:zubair_onward_academy/view/otp_verification_screen.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/view/register_screen.dart';
import 'package:zubair_onward_academy/view/category_screen.dart';
import 'package:zubair_onward_academy/view/splash_screen.dart';
import 'package:zubair_onward_academy/view/booksData/books_screen.dart';
import 'package:zubair_onward_academy/view/login_screen.dart';
import 'package:flutter/material.dart';


class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RoutesName.register:
        return MaterialPageRoute(builder: (BuildContext context) => const RegisterScreen());
      case RoutesName.verify:
        return MaterialPageRoute(builder: (BuildContext context) => const OtpVerificationScreen());
      case RoutesName.category:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoriesScreen());
      case RoutesName.books:
        return MaterialPageRoute(builder: (BuildContext context) => const BooksScreen(categoryId: '',));
      case RoutesName.lectures:
        return MaterialPageRoute(builder: (BuildContext context) => const LecturesScreen(categoryId: '',));
      case RoutesName.mcqs:
        return MaterialPageRoute(builder: (BuildContext context) => const McqsScreen(categoryId: '',));
      case RoutesName.notes:
        return MaterialPageRoute(builder: (BuildContext context) => const NotesScreen(categoryId: '',));
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }

}