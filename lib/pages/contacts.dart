import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> teamMembers = {
      'Member1': {
        'name': 'Eduardo Vázquez Huerta',
        'phone': '9611272389',
      },
      'Member2': {
        'name': 'Maria Jose Domínguez Costa',
        'phone': '9631333708',
      },
      'Member3': {
        'name': 'Manuel Alejandro Peregrino Clemente',
        'phone': '9612458375',
      },
    };

    final List<Widget> teamMembersList = teamMembers.entries.map((entry) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            entry.value['name'] ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.blue),
                onPressed: () async {
                  final phoneNumber = Uri.parse('tel:${entry.value['phone']}');
                  if (await canLaunchUrl(phoneNumber)) {
                    await launchUrl(phoneNumber);
                  } else {
                    throw 'Could not launch $phoneNumber';
                  }
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.blue),
                onPressed: () async {
                  final messageNumber = Uri.parse('sms:${entry.value['phone']}');
                  if (await canLaunchUrl(messageNumber)) {
                    await launchUrl(messageNumber);
                  } else {
                    throw 'Could not launch $messageNumber';
                  }
                },
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Team 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ...teamMembersList,
        ],
      ),
    );
  }
}
