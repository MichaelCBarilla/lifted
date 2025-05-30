import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifted/src/features/authentication/domain/app_user.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';
import 'package:lifted/src/routing/app_router.dart';

enum PopupMenuOption {
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key, this.user});
  final AppUser? user;

  // * Keys for testing using find.byKey()
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return <PopupMenuEntry<PopupMenuOption>>[
          PopupMenuItem(
            key: accountKey,
            value: PopupMenuOption.account,
            child: Text('Account'.hardcoded),
          ),
        ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.account:
            context.goNamed(AppRoute.account.name);
            break;
        }
      },
    );
  }
}
