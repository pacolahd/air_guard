import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});
  static const routeName = '/personal-info';

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      appBar: AppBar(
        title: Text(
          'Personal Information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                      ),
                    ),
                    SizedBox(height: 16),
                    // const ProfileHeader(),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .primaryColor, // Using app primary color
                  ),
                ),
              ),
              SizedBox(height: 24),
              Consumer<UserProvider>(
                builder: (_, userProvider, __) {
                  final user = userProvider.user;
                  // final fullName =
                  //     '${user?.firstName ?? ''} ${user?.lastName ?? ''}';
                  final fullName = '${user?.fullName}';
                  final email = user?.email ?? '';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildDetailRow(
                        context,
                        'Full Name',
                        fullName,
                        Icons.edit,
                        () => _showEditDialog(
                          context,
                          'Name',
                          fullName,
                          userProvider,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildDetailRow(
                        context,
                        'Email',
                        email,
                        Icons.edit,
                        () => _showEditDialog(
                          context,
                          'Email',
                          email,
                          userProvider,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    VoidCallback onEditPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          icon: Icon(icon, color: Theme.of(context).primaryColor),
          onPressed: onEditPressed,
        ),
      ],
    );
  }

  void _showEditDialog(
    BuildContext context,
    String field,
    String currentValue,
    UserProvider userProvider,
  ) {
    final TextEditingController _controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: SingleChildScrollView(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter new $field',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedValue = _controller.text;
                // Uncomment and handle update logic here
                // if (field == 'Name') {
                //   final names = updatedValue.split(' ');
                //   final firstName = names.isNotEmpty ? names[0] : '';
                //   final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';
                //   userProvider.updateUserName(firstName, lastName);
                // } else if (field == 'Email') {
                //   userProvider.updateUserEmail(updatedValue);
                // }
                Navigator.of(context).pop();
              },
              child: Text('Save',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }
}
