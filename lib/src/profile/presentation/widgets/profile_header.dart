import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, userProvider, __) {
        final user = userProvider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        return Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: image == null
                  ? const AssetImage(MediaRes.user)
                  : NetworkImage(user?.profilePic ?? MediaRes.user),
            ),
            const SizedBox(height: 10),
            Text(
              (user?.fullName != null && user?.fullName != null)
                  ? '${user?.fullName} ${user?.fullName}'
                  : 'No User',
              style: context.theme.textStyles.bodySmall,
            ),
            Text(
              user != null ? user.email : '',
              style: context.theme.textStyles.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
