import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneNumberInput extends StatefulWidget {
  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneNumberController = TextEditingController();

  // Function to request contact permissions
  Future<void> _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      // Fetch contacts
      Iterable<Contact> contacts = await ContactsService.getContacts();

      // Show contact selection dialog
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(
            children: contacts.map((contact) {
              return ListTile(
                title: Text(contact.displayName ?? "No Name"),
                subtitle: contact.phones != null && contact.phones!.isNotEmpty
                    ? Text(contact.phones!.first.value ?? "")
                    : const Text("No Phone Number"),
                onTap: () {
                  // Populate phone number field
                  if (contact.phones != null && contact.phones!.isNotEmpty) {
                    _phoneNumberController.text = contact.phones!.first.value!;
                  }
                  Navigator.pop(context); // Close the modal
                },
              );
            }).toList(),
          );
        },
      );
    } else {
      // Show an alert if permissions are denied
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Permission Required"),
          content: const Text("Please grant contacts access to select a contact."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneNumberController,
      decoration: InputDecoration(
        labelText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: GestureDetector(
          onTap: _selectContact, // Open phonebook
          child: Image.asset("assets/images/appAssets/contact.png"),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
