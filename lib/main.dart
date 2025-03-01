import 'package:zubair_onward_academy/viewmodel/category_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/books_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/auth_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/lectures_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/mcqs_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/notes_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/user_view_model.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((fn){
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => CategoryViewModel()),
          ChangeNotifierProvider(create: (_) => BooksViewModel()),
          ChangeNotifierProvider(create: (_) => NotesViewModel()),
          ChangeNotifierProvider(create: (_) => McqsViewModel()),
          ChangeNotifierProvider(create: (_) => LecturesViewModel()),
    ],

    child: const MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,

    ),
    );
  }
}
