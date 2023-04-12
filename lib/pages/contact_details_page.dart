import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/ContactModel.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = "/contact_details";

  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool isFirst = true;
  late ContactProvider _contactProvider;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _contactProvider = Provider.of<ContactProvider>(context,listen: false);
      if (ModalRoute.of(context)?.settings.arguments != null) {
        //contact = ModalRoute.of(context)?.settings.arguments as ContactModel;
        final id = ModalRoute.of(context)?.settings.arguments as int;
        _contactProvider.getContact(id);
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
        body: (context.watch<ContactProvider>().contact == null)
            ? const Center(child: Text('Please wait'))
            : Consumer<ContactProvider>(
              builder:(context, provider, child) =>  ListView(
                  children: [
                    Image.asset(provider.contact?.image ?? '',
                        width: double.infinity, height: 250, fit: BoxFit.cover),
                    ListTile(
                      title: Text(provider.contact?.contactName ?? ''),
                    ),
                    ListTile(
                      title: Text(provider.contact?.mobile ?? ''),
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
                      title: Text(provider.contact?.email.isEmpty ?? true
                          ? 'Not Found'
                          : provider.contact?.email ?? ''),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.email)),
                    ),
                    ListTile(
                      title: Text(provider.contact?.address.isEmpty ?? true
                          ? 'Not Found'
                          : provider.contact?.address ?? 'gfhd'),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.location_on)),
                    ),
                    ListTile(
                      title: Text(provider.contact?.website.isEmpty ?? true
                          ? 'Not Found'
                          : provider.contact?.website ?? 'sdfds'),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.web)),
                    ),
                  ],
                ),
            ));
  }

  Future<bool> _showDialog(BuildContext context) async{
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<ContactProvider>(
          builder:(context, value, child) =>  AlertDialog(
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
                  _contactProvider.deleteContact(value.contact?.id??-1).then((value) => Navigator.pop(context, true));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
