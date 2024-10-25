import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});
  static const routeName = '/help-and-support';

  @override
  Widget build(BuildContext context) {
    final Color customRed = const Color.fromRGBO(153, 27, 28, 1);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Help & Support', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            _buildSectionHeader('Frequently Asked Questions', Colors.black),
            _buildFAQSection(
              'How do I use this app?',
              'To use this app, navigate through the bottom navigation bar to access different sections such as Home, Sermons, Events, Community, and Profile.',
              Colors.black,
            ),
            _buildFAQSection(
              'How can I contact support?',
              'You can contact support by emailing us at support@churchapp.com or calling us at (123) 456-7890.',
              Colors.black,
            ),
            _buildFAQSection(
              'How do I reset my password?',
              'To reset your password, go to the Profile section, click on "Change password" and follow the instructions.',
              Colors.black,
            ),
            const SizedBox(height: 16),
            _buildSectionHeader('Contact Us', Colors.black),
            _buildContactTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'janetteakua@gmail.com',
              customRed: customRed,
              //onTap: () => _launchEmail(),
            ),
            _buildContactTile(
              icon: Icons.phone,
              title: 'Phone',
              subtitle: '+233 545757948',
              customRed: customRed,
              onTap: () => _launchPhone('+233545757948'),
            ),
            _buildContactTile(
              icon: Icons.location_on,
              title: 'Address',
              subtitle: 'Ashesi University, The Hive',
              customRed: customRed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget _buildFAQSection(String question, String answer, Color color) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        children: <Widget>[
          ListTile(
            title: Text(answer, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color customRed,
    void Function()? onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: customRed),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: customRed),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: onTap,
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    // final bool? result = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    // if (result == null || !result) {
    //   // Handle error if the phone call can't be made
    //   debugPrint('Could not launch phone dialer');
    // }
  }
}
