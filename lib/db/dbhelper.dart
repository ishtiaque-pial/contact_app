import 'package:contact_app/models/ContactModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DbHelper {

  Future<Database> _open() async{
    const String _createTableContact = '''create table $tableContact(
    $tblContactId integer primary key autoincrement,
    $tblContactName text,
    $tblContactMobile text,
    $tblContactEmail text, 
    $tblContactAddress text,
    $tblContactCompany text,
    $tblContactDesignation text,
    $tblContactWebsite text,
    $tblContactFavorite integer,
    $tblContactImage text)''';
    final root = await getDatabasesPath();
    final dbPAth = p.join(root,'contact.db');
    
    return openDatabase(
      dbPAth,
      version: 1,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
    );
  }

  Future<int> insert(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact,contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContact() async{
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }
  
  Future<ContactModel> getContact(int id) async{
    final db = await _open();
    final mapList = await db.query(tableContact,where: '$tblContactId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }

  Future<List<ContactModel>> getFavoriteContact() async{
    final db = await _open();
    final mapList = await db.query(tableContact,where: '$tblContactFavorite = ?', whereArgs: [1]);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  Future<int> deleteContact(int id) async{
    final db = await _open();
    return await db.delete(tableContact,where: '$tblContactId = ?', whereArgs: [id]);
  }

  Future<int> updateContactField(int id, Map<String,dynamic> map) async {
    final db = await _open();
    return db.update(tableContact, map, where: '$tblContactId = ?', whereArgs: [id]);
  }
}