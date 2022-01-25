import 'package:band_names/pages/pages.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:band_names/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => SocketService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: AppTheme.lightTheme,
        initialRoute: 'home',
        routes: {
          'home' : ( _ ) => HomePage(),
          'status' : ( _ ) => StatusPage()
        },
      ),
    );
  }
}