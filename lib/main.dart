import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_groupe_c/pages/display_intervention_page.dart';
import 'globals.dart' as globals;

void main() async{
  globals.token = '';
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: DisplayIntervention()),
    );
  }
}
