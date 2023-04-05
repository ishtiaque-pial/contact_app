class ContactModel {
  int id;
  String contactName;
  String mobile;
  String email;
  String address;
  String website;
  String image;
  String company;
  bool isFav;

  ContactModel(
      {this.id = -1,
      required this.contactName,
      required this.mobile,
      this.email='',
      this.address='',
      this.website='',
      this.image='images/person.png',
      this.company='',
      this.isFav=false});
}
