
import 'package:flutter/cupertino.dart';

abstract class RoutePath {
  String get path;
  String get key;
  Object? get state => null;

  Widget get widget;
}