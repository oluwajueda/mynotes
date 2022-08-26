import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialogue<void>(
      context: context,
      title: 'Password Reset',
      content:
          'We have now sent you a password reset link. Please check your email for more information.',
      optionsBuilder: () => {
            'OK': null,
          });
}
