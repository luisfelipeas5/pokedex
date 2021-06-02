import 'package:flutter/material.dart';
import 'package:pokedex/router/RouterState.dart';
import 'package:provider/provider.dart';

class MyBackButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BackButton(onPressed: () {
      final routerState = Provider.of<RouterState>(context, listen: false);
      routerState.pop();
    },);
  }
}