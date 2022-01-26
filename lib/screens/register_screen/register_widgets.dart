import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({
    Key? key,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey,
        super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.back,
      ),
      onPressed: () {
        _navigatorKey.currentState!.pop();
      },
    );
  }
}
