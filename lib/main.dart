import 'package:contact_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AllRoutes.contact,
        routes: AllRoutes.AppRoutes,
      ),
    );
  }
}
