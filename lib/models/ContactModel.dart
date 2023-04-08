import 'package:flutter/foundation.dart';

const String tableContact = 'tbl_contact';
const String tblContactId = 'id';
const String tblContactName = 'name';
const String tblContactMobile = 'mobile';
const String tblContactEmail = 'email';
const String tblContactAddress = 'address';
const String tblContactWebsite = 'website';
const String tblContactImage = 'image';
const String tblContactCompany = 'company';
const String tblContactDesignation = 'designation';
const String tblContactFavorite = 'favorite';

class ContactModel {
  int id;
  String contactName;
  String mobile;
  String email;
  String address;
  String website;
  String designation;
  String image;
  String company;
  bool isFav;

  ContactModel(
      {this.id = -1,
      required this.contactName,
      required this.mobile,
      this.email = '',
      this.address = '',
      this.designation = '',
      this.website = '',
      this.image = 'images/person.png',
      this.company = '',
      this.isFav = false});

  factory ContactModel.fromMap(Map<String,dynamic> map) => ContactModel(
      contactName: map[tblContactName],
      mobile: map[tblContactMobile],
      id: map[tblContactId],
      email: map[tblContactEmail],
      address: map[tblContactAddress],
      website: map[tblContactWebsite],
      company: map[tblContactCompany],
      image: map[tblContactImage],
      isFav: map[tblContactFavorite]==1,

  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactName: contactName,
      tblContactMobile: mobile,
      tblContactEmail: email,
      tblContactDesignation: designation,
      tblContactCompany: company,
      tblContactAddress: address,
      tblContactWebsite: website,
      tblContactImage: image,
      tblContactFavorite: isFav ? 1 : 0,
    };
    if(id>0) {
      map[tblContactId] = id;
    }
    return map;
  }
}
