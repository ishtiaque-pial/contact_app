import 'package:contact_app/db/temp_db.dart';
import 'package:contact_app/models/ContactModel.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatefulWidget {
  static const String routeName = "/contact_form_page";

  const ContactFormPage({Key? key}) : super(key: key);

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final webController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    companyController.dispose();
    webController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        actions: [
          InkWell(
            onTap: _saveContact,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('SAVE')),
            ),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length > 20) {
                  return 'Name is too long(Max20)';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mobile Number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email))),
            const SizedBox(height: 10),
            TextFormField(
                controller: designationController,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Designation',
                    prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 10),
            TextFormField(
                controller: companyController,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Company Name',
                    prefixIcon: Icon(Icons.compare_outlined))),
            const SizedBox(height: 10),
            TextFormField(
              controller: webController,
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Website',
                  prefixIcon: Icon(Icons.web)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Location Name',
                  prefixIcon: Icon(Icons.location_on)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
          id: contactList.length + 1,
          contactName: nameController.text,
          mobile: mobileController.text,
          address: addressController.text,
          company: companyController.text,
          designation: designationController.text,
          website: webController.text,
          email: emailController.text,
      );
      contactList.add(contact);
      Navigator.pop(context);
    }
  }
}
