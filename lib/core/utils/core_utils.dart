import 'dart:io';

import 'package:air_guard/core/common/widgets/custom_loading_indicator.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum MessageType { success, error, warning, info }

class CoreUtils {
  const CoreUtils._();

  static void unfocusAllFields(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: CustomLoadingIndicator(),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Just a moment...',
                        style: TextStyle(
                          color: AppColors.textColor.lightPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showMessageDialog(
    BuildContext context, {
    required String title,
    required String message,
    required MessageType type,
    VoidCallback? onDismiss,
  }) {
    Color getColor() {
      switch (type) {
        case MessageType.success:
          return AppColors.feedback.success;
        case MessageType.error:
          return AppColors.feedback.error;
        case MessageType.warning:
          return AppColors.feedback.warning;
        case MessageType.info:
          return AppColors.feedback.info;
      }
    }

    IconData getIcon() {
      switch (type) {
        case MessageType.success:
          return Icons.check_circle;
        case MessageType.error:
          return Icons.error;
        case MessageType.warning:
          return Icons.warning;
        case MessageType.info:
          return Icons.info;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      getIcon(),
                      color: getColor(),
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor.lightPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textColor.lightSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.ui.darkBlue, // Dark blue
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: onDismiss ??
                      () {
                        Navigator.of(context).pop();
                      },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

//   static void sendNotification(
//       BuildContext context, {
//         required String title,
//         required String body,
//         required NotificationCategory category,
//       }) {
//     context.read<NotificationCubit>().sendNotification(
//       NotificationModel.empty().copyWith(
//         title: title,
//         body: body,
//         category: category,
//       ),
//     );
//   }
}
