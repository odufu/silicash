import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class PhoneNumberInput extends StatefulWidget {
  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneNumberController = TextEditingController();

  // Function to request contact permissions and fetch contacts
  Future<void> _selectContact() async {
    // Check if the permission is granted
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      // Request the permission
      status = await Permission.contacts.request();
    }

    if (status.isGranted) {
      // Fetch contacts
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);

      // Show contact selection dialog
      if (contacts.isNotEmpty) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final phoneNumbers = contact.phones;

                return ListTile(
                  title: Text(contact.displayName ?? "No Name"),
                  subtitle: phoneNumbers.isNotEmpty
                      ? Text(phoneNumbers.first.number)
                      : const Text("No Phone Number"),
                  onTap: () {
                    // Populate phone number field
                    if (phoneNumbers.isNotEmpty) {
                      _phoneNumberController.text = phoneNumbers.first.number;
                    }
                    Navigator.pop(context); // Close the modal
                  },
                );
              },
            );
          },
        );
      } else {
        _showAlert("No Contacts", "No contacts were found in your phone.");
      }
    } else {
      // Handle denied permission
      _showAlert("Permission Required",
          "Please grant contacts access to select a contact. You can enable it in the app settings.",
          isSettings: true);
    }
  }

  void _showAlert(String title, String message, {bool isSettings = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
          if (isSettings)
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings(); // Open app settings
              },
              child: const Text("Settings"),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneNumberController,
      maxLength: 11,
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
