import 'dart:convert';
import 'dart:io';

import 'package:air_guard/core/enums/update_enums.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:air_guard/core/utils/core_utils.dart';
import 'package:air_guard/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:air_guard/src/profile/presentation/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get firstNameChanged =>
      context.currentUser?.fullName.trim() != firstNameController.text.trim();
  // bool get lastNameChanged =>
  //     context.currentUser?.firstName.trim() != lastNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;
  //
  // bool get ageChanged =>
  //     context.currentUser?.age.toString() != ageController.text.trim();
  //
  // bool get genderChanged =>
  //     context.currentUser?.gender.trim() != genderController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !firstNameChanged &&
      // !lastNameChanged &&
      !emailChanged &&
      !passwordChanged &&
      // !ageChanged &&
      // !genderChanged &&
      !imageChanged;

  @override
  void initState() {
    super.initState();
    final user = context.currentUser!;

    firstNameController.text = user.fullName.trim();
    // lastNameController.text = user.lastName.trim();
    emailController.text = user.email.trim();
    // ageController.text = user.age.toString();
    // genderController.text = user.gender.trim();
  }

  @override
  void dispose() {
    firstNameController.dispose();

    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Profile updated Successfully');
          Navigator.pop(context);
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (nothingChanged) Navigator.pop(context);
                    final bloc = context.read<AuthBloc>();
                    if (passwordChanged) {
                      if (oldPasswordController.text.isEmpty) {
                        CoreUtils.showSnackBar(
                          context,
                          'Please enter your old password',
                        );
                        return;
                      }
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.password,
                          userData: jsonEncode({
                            'oldPassword': oldPasswordController.text.trim(),
                            'newPassword': passwordController.text.trim(),
                          }),
                        ),
                      );
                    }
                    if (firstNameChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.fullName,
                          userData: firstNameController.text.trim(),
                        ),
                      );
                    }
                    if (emailChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.email,
                          userData: emailController.text.trim(),
                        ),
                      );
                    }
                    // if (lastNameChanged) {
                    //   bloc.add(
                    //     UpdateUserEvent(
                    //       action: UpdateUserAction.lastName,
                    //       userData: lastNameController.text.trim(),
                    //     ),
                    //   );
                    // }
                    // if (ageChanged) {
                    //   bloc.add(
                    //     UpdateUserEvent(
                    //       action: UpdateUserAction.age,
                    //       userData: ageController.text.trim(),
                    //     ),
                    //   );
                    // }
                    // if (genderChanged) {
                    //   bloc.add(
                    //     UpdateUserEvent(
                    //       action: UpdateUserAction.gender,
                    //       userData: genderController.text.trim(),
                    //     ),
                    //   );
                    // }
                    if (imageChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.profilePic,
                          userData: pickedImage,
                        ),
                      );
                    }
                  },
                  child: state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : StatefulBuilder(
                          builder: (_, refresh) {
                            firstNameController
                                .addListener(() => refresh(() {}));
                            lastNameController
                                .addListener(() => refresh(() {}));

                            emailController.addListener(() => refresh(() {}));
                            passwordController
                                .addListener(() => refresh(() {}));
                            ageController.addListener(() => refresh(() {}));
                            genderController.addListener(() => refresh(() {}));
                            return Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: nothingChanged
                                    ? Colors.grey
                                    : Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: pickedImage != null
                      ? FileImage(pickedImage!)
                      : (context.currentUser!.profilePic != null
                          ? NetworkImage(context.currentUser!.profilePic!)
                          : const AssetImage(MediaRes.user)) as ImageProvider,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      IconButton(
                        onPressed: pickImage,
                        icon: Icon(
                          (pickedImage != null ||
                                  context.currentUser!.profilePic != null)
                              ? Icons.edit
                              : Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'We recommend an image of at least 400x400',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF777E90),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                EditProfileForm(
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  oldPasswordController: oldPasswordController,
                  ageController: ageController,
                  genderController: genderController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
