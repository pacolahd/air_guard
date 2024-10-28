import 'package:air_guard/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsScreen extends StatefulWidget {
  static const routeName = '/emergency-contacts';
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
  List<Contact> emergencyContacts = [];

  void _showAddContactOptions() {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text("Select from Contacts"),
              onTap: () {
                Navigator.pop(context);
                _pickContactFromPhone();
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add New Contact"),
              onTap: () {
                Navigator.pop(context);
                _showAddNewContactDialog();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickContactFromPhone() async {
    try {
      final Contact? contact = await _contactPicker.selectContact();
      if (contact != null) {
        _addEmergencyContact(contact);
      }
    } catch (e) {
      print("Failed to pick contact: $e");
    }
  }

  void _showAddNewContactDialog() {
    String name = '';
    String phone = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _createAndAddNewContact(name, phone);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createAndAddNewContact(String name, String phone) async {
    final newContact = Contact(fullName: name, phoneNumbers: [phone]);
    _addEmergencyContact(newContact);
  }

  void _addEmergencyContact(Contact contact) {
    if (!emergencyContacts.any((c) => c.fullName == contact.fullName && c.phoneNumbers == contact.phoneNumbers)) {
      setState(() {
        emergencyContacts.add(contact);
      });
    }
  }

  void _callContact(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch phone call');
    }
  }

  void _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      print('Could not send SMS');
    }
  }

  void _deleteContact(Contact contact) {
    setState(() {
      emergencyContacts.remove(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Emergency Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddContactOptions,
          ),
        ],
      ),
      body: emergencyContacts.isEmpty
          ? const Center(child: Text("No emergency contacts added."))
          : ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: const AssetImage(MediaRes.user),
            ),
            title: Text(contact.fullName ?? 'Unknown Name'),
            subtitle: Text(contact.phoneNumbers?[0] ?? 'No phone number'),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Call') {
                  _callContact(contact.phoneNumbers?.first ?? '');
                } else if (value == 'Message') {
                  _sendSMS(contact.phoneNumbers?.first ?? '');
                } else if (value == 'Delete') {
                  _deleteContact(contact);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'Call', child: Text("Call")),
                const PopupMenuItem(value: 'Message', child: Text("Send SMS")),
                const PopupMenuItem(value: 'Delete', child: Text("Delete")),
              ],
            ),
          );
        },
      ),
    );
  }
}
