import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/ContactModel.dart';
import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = "/contact_details";

  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool isFirst = true;
  ContactModel? contact;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        //contact = ModalRoute.of(context)?.settings.arguments as ContactModel;
        final id = ModalRoute.of(context)?.settings.arguments as int;
        DbHelper().getContact(id).then(
          (value) {
            contact = value;
            setState(() {});
          },
        );
        isFirst = false;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Details'),
          actions: [
            IconButton(
                onPressed: () {
                  _showDialog(context).then((value) {
                    showMsg(context, 'Deleted');
                    Navigator.pop(context,true);
                  },);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: (contact == null)
            ? const Center(child: Text('Please wait'))
            : ListView(
                children: [
                  Image.asset(contact?.image ?? '',
                      width: double.infinity, height: 250, fit: BoxFit.cover),
                  ListTile(
                    title: Text(contact?.contactName ?? ''),
                  ),
                  ListTile(
                    title: Text(contact?.mobile ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.sms)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.call)),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(contact?.email.isEmpty ?? true
                        ? 'Not Found'
                        : contact?.email ?? ''),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.email)),
                  ),
                  ListTile(
                    title: Text(contact?.address.isEmpty ?? true
                        ? 'Not Found'
                        : contact?.address ?? 'gfhd'),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.location_on)),
                  ),
                  ListTile(
                    title: Text(contact?.website.isEmpty ?? true
                        ? 'Not Found'
                        : contact?.website ?? 'sdfds'),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.web)),
                  ),
                ],
              ));
  }

  Future<bool> _showDialog(BuildContext context) async{
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog'),
          content: const Text('Would you like to delete this contact?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                DbHelper().deleteContact(contact?.id??-1).then((value) => Navigator.pop(context, true));
              },
            ),
          ],
        );
      },
    );
  }
}
