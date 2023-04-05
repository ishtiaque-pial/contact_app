import 'package:contact_app/db/temp_db.dart';
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:flutter/material.dart';

class ContactHomePage extends StatefulWidget {
  static const String routeName = '/';

  const ContactHomePage({Key? key}) : super(key: key);

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact App"),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, ContactDetailsPage.routeName, arguments: contact);
            },
            title: Text(
              contact.contactName,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(contact.mobile),
            trailing: Icon(Icons.favorite_border),
          );
        },
      ),
    );
  }
}
