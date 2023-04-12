
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ContactModel.dart';

class ContactHomePage extends StatefulWidget {
  static const String routeName = '/';
  const ContactHomePage({Key? key}) : super(key: key);

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  int selectedIndex = 0;
  late ContactProvider _contactProvider;
  bool isFirst=true;

  @override
  void didChangeDependencies() {
    if(isFirst) {
      _contactProvider = Provider.of<ContactProvider>(context, listen: false);
      _getContact();
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App"),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex=value;
            });
            _getContact();
          },
          currentIndex: selectedIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'All'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
          ],
        ),
      ),
      body: (context.watch<ContactProvider>().contactList.isNotEmpty)
          ? Consumer<ContactProvider>(
            builder:(context, provider, child) => ListView.builder(
                itemCount: provider.contactList.length,
                itemBuilder: (context, index) {
                  final contact = provider.contactList[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, ContactDetailsPage.routeName,
                          arguments: contact.id).then((value) {
                            if(value is bool && value){
                              _contactProvider.contactDelete(index);
                            }
                          },);
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
                              _handleTap(ContactFormPage.routeName,
                                  contactModel: contact, index: index);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              contact.isFav = !contact.isFav;
                              _contactProvider
                                  .updateContactFieldFromHome(contact, contact.toMap(),index,selectedIndex);

                            },
                            icon: contact.isFav
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)),
                      ],
                    ),
                  );
                },
              ),
          )
          : const Center(
              child: Text('No Data found'),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer<ContactProvider>(
        builder:(context, provider, child) =>  FloatingActionButton(
          onPressed: () {
            _handleTap(ContactFormPage.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _handleTap(String routeName,
      {ContactModel? contactModel, int? index}) async {
    final contact =
        await Navigator.pushNamed(context, routeName, arguments: contactModel);
    if (contact != null) {
      if (index == null) {
        _contactProvider.contactAdd(contact as ContactModel);
      } else {
        _contactProvider.contactUpdate(index, contact as ContactModel);
      }
    }
  }

  void _getContact() {
    if(selectedIndex==0) {
      _contactProvider.getAllContact();
    } else {
      _contactProvider.getFavoriteContact();
    }
  }
}
