import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:air_guard/core/services/injection_container.dart';
import 'package:air_guard/src/auth/data/models/user_model.dart';
import 'package:air_guard/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:air_guard/src/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:air_guard/src/emergency_contacts/presentation/view/emergency_contacts_screen.dart';
import 'package:air_guard/src/home/presentation/views/home_screen.dart';
import 'package:air_guard/src/profile/presentation/views/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  List<Widget> _buildScreens() {
    return [
      // Container(,
      // Profile(),
      // Notifications(),
      // Settings(),
    ];
  }

  List<PersistentTabConfig> _tabs() => [

    PersistentTabConfig(
      screen:  HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.home),
        title: "Home",
        activeForegroundColor: Colors.blue,
        inactiveBackgroundColor: Colors.white,
      ),
    ),
    PersistentTabConfig(
      screen: EmergencyContactsScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.contact_emergency),
        title: "Emergency Contacts",
        activeForegroundColor: Colors.blue,
        inactiveBackgroundColor: Colors.white,
      ),
    ),
    PersistentTabConfig(
      screen: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
        ],
        child: const ProfilePage(),
      ),
      item: ItemConfig(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeForegroundColor: Colors.blue,
        inactiveBackgroundColor: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is UserModel) {
          context.read<UserProvider>().user = snapshot.data;
          debugPrint('User: ${snapshot.data}');
          debugPrint(context.read<UserProvider>().user.toString());
        }
        return Scaffold(
          body: PersistentTabView(
            controller: _controller,
            // backgroundColor: Colors.red,
            tabs: _tabs(),
            navBarBuilder: (navBarConfig) => Style4BottomNavBar(
              navBarConfig: navBarConfig,
              navBarDecoration: NavBarDecoration(color: Colors.transparent),
            ),
            navBarOverlap: NavBarOverlap.full(),
            // resizeToAvoidBottomInset: true,
            // avoidBottomPadding: true,

          ),
        );
      },
    );
  }
}
