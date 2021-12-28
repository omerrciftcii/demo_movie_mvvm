import 'package:demo_movie_mvvm/providers/movie_provider.dart';
import 'package:demo_movie_mvvm/providers/theme_provider.dart';
import 'package:demo_movie_mvvm/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var theme = preferences.getString('theme');

  runApp(MyApp(
    theme: theme,
  ));
}

class MyApp extends StatelessWidget {
  final String? theme;
  MyApp({required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      builder: (context, child) {
    

        return MaterialApp(
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).themeData == null
              ? theme == 'light'
                  ? Provider.of<ThemeProvider>(context).lightTheme
                  : Provider.of<ThemeProvider>(context).darkTheme
              : Provider.of<ThemeProvider>(context).themeData,
          home: const HomeScreen(),
        );
      },
    );
  }
}
