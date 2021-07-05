import 'package:flutter/material.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Indicator>(create: (context)=>Indicator(),),
        ChangeNotifierProvider<UserModelUsed>(create: (context)=>UserModelUsed())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.teal,
          ),
          home: LoginScreen(),
        ),
    );
  }
}
