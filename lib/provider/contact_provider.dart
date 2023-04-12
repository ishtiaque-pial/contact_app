import 'package:contact_app/db/dbhelper.dart';
import 'package:flutter/material.dart';

import '../models/ContactModel.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final DbHelper _dbHelper = DbHelper();
  ContactModel? contact;

  Future<int> insert(ContactModel contactModel) {
    return _dbHelper.insert(contactModel);
  }

  getAllContact() async {
    contactList = await _dbHelper.getAllContact();
    notifyListeners();
  }

  getFavoriteContact() async {
    contactList = await _dbHelper.getFavoriteContact();
    notifyListeners();
  }

  updateContactFieldFromHome(ContactModel contactModel, Map<String, dynamic> map,
      int index, int currentPage) {
    _dbHelper.updateContactField(contactModel.id, map).then(
      (value) {
        if (currentPage == 0) {
          contactUpdate(index, contactModel);
        } else {
          contactDelete(index);
        }
      },
    );
  }

  Future<int> updateContactField(int id, Map<String, dynamic> map,) {
    return _dbHelper.updateContactField(id, map);
  }

  contactAdd(ContactModel contactModel) {
    contactList.add(contactModel);
    notifyListeners();
  }

  contactUpdate(int index, ContactModel contactModel) {
    contactList[index] = contactModel;
    notifyListeners();
  }

  contactDelete(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

   getContact(int id){
    _dbHelper.getContact(id).then((value) {
      contact =value;
      notifyListeners();
    },);
  }

  deleteContact(int id) {
    return _dbHelper.deleteContact(id);
  }
}
