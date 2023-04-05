import 'package:contact_app/db/temp_db.dart';
import 'package:contact_app/models/ContactModel.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = "/contact_details";

  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool isFirst = true;
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      if(ModalRoute.of(context)?.settings.arguments !=null) {
        contact = ModalRoute.of(context)?.settings.arguments as ContactModel;
      } else {
        contact = contactList[0];
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: ListView(
        children: [
          Image.asset(contact.image, width: double.infinity, height: 250,fit: BoxFit.cover),
          ListTile(
            title: Text(contact.contactName),
          ),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.sms)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email.isEmpty? 'Not Found': contact.email),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.email)),
          ),
          ListTile(
            title: Text(contact.address.isEmpty? 'Not Found': contact.address),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.location_on)),
          ),
          ListTile(
            title: Text(contact.website.isEmpty? 'Not Found': contact.website),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.web)),
          ),
        ],
      )
    );
  }
}
