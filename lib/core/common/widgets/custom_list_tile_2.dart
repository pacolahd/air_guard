import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:flutter/material.dart';

class CustomListTile2 extends StatelessWidget {
  const CustomListTile2({
    required this.title,
    required this.value,
    required this.onPressed,
    this.leadingIconUrl,
    this.trailingIconUrl,
    super.key,
  });
  final String title;
  final bool value;
  final String? leadingIconUrl;
  final String? trailingIconUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            if (leadingIconUrl != null)
              Image.asset(
                leadingIconUrl!,
                color: context.theme.colorScheme.tertiary,
              ),
            if (leadingIconUrl != null) const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: context.theme.textStyles.bodySmall,
              ),
            ),
            Image.asset(
              trailingIconUrl ?? MediaRes.googleIcon,
              color: context.theme.colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
