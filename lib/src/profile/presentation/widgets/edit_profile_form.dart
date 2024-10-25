import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/src/profile/presentation/widgets/edit_profile_form_field.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.ageController,
    required this.genderController,
    super.key,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController ageController;
  final TextEditingController genderController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'First NAME',
          controller: firstNameController,
          hintText: context.currentUser!.fullName,
        ),
        // EditProfileFormField(
        //   fieldTitle: 'Last NAME',
        //   controller: lastNameController,
        //   hintText: context.currentUser!.firstName,
        // ),
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email,
        ),
        // EditProfileFormField(
        //   fieldTitle: 'AGE',
        //   controller: ageController,
        //   hintText: context.currentUser!.age.toString(),
        // ),
        // EditProfileFormField(
        //   fieldTitle: 'GENDER',
        //   controller: genderController,
        //   hintText: context.currentUser!.gender,
        // ),
        EditProfileFormField(
          fieldTitle: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              fieldTitle: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
      ],
    );
  }
}
