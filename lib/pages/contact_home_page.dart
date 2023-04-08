import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:flutter/material.dart';

import '../models/ContactModel.dart';

class ContactHomePage extends StatefulWidget {
  static const String routeName = '/';

  const ContactHomePage({Key? key}) : super(key: key);

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  List<ContactModel> contactList = [];

  @override
  void initState() {
    DbHelper().getAllContact().then((value) {
      contactList = value;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App"),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, ContactDetailsPage.routeName,
                  arguments: contact);
            },
            title: Text(
              contact.contactName,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      _handleTap(ContactFormPage.routeName,contactModel: contact,index: index);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      contact.isFav = !contact.isFav;
                      DbHelper().updateContactField(contact.id, contact.toMap()).then((value) {
                        contactList[index]=contact;
                        setState(() {

                        });
                      },);
                    },
                    icon: contact.isFav? const Icon(Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_border)),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleTap(ContactFormPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleTap(String routeName, {ContactModel? contactModel,int? index}) async {
    final contact =
    await Navigator.pushNamed(context, routeName,arguments: contactModel);
    if (contact != null) {
      if(index==null) {
        contactList.add(contact as ContactModel);
      } else {
        contactList[index] = contact as ContactModel;
      }
    }
    setState(() {});
  }
}
