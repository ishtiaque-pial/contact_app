import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:contact_app/pages/contact_home_page.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactHomePage.routeName,
      routes: {
        ContactHomePage.routeName: (context) => const ContactHomePage(),
        ContactDetailsPage.routeName: (context) => const ContactDetailsPage(),
        ContactFormPage.routeName: (context) => const ContactFormPage()
      },
    );
  }
}
