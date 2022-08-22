import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, ModalRoute;

// used to create or get existing note by passing a function

extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
