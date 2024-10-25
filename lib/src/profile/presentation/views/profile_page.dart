import 'dart:async';

import 'package:air_guard/core/common/widgets/custom_list_tile_2.dart';
import 'package:air_guard/core/common/widgets/theme_toggle_dropdown.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:air_guard/src/profile/presentation/views/about_air_guard.dart';
import 'package:air_guard/src/profile/presentation/views/edit_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile-page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.userProvider;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // show dialog
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const SizedBox(height: 70),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Settings',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ThemeToggle(),
                  const SizedBox(height: 10),
                  CustomListTile2(
                    leadingIconUrl: MediaRes.googleIcon,
                    title: 'Personal Information',
                    value: true,
                    onPressed: () {
                      Navigator.pushNamed(context, EditProfileScreen.routeName);
                    },
                  ),
                  CustomListTile2(
                    leadingIconUrl: MediaRes.googleIcon,
                    title: 'Help and support',
                    value: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/help-and-support');
                    },
                  ),
                  CustomListTile2(
                    leadingIconUrl: MediaRes.googleIcon,
                    title: 'About KCF',
                    value: true,
                    onPressed: () {
                      Navigator.pushNamed(context, AboutAirGuard.routeName);
                    },
                  ),
                  CustomListTile2(
                    leadingIconUrl: MediaRes.googleIcon,
                    title: 'Logout',
                    value: true,
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      unawaited(
                        navigator.pushNamedAndRemoveUntil(
                          '/',
                          (route) => false,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
