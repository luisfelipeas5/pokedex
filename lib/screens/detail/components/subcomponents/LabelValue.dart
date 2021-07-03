
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Label.dart';

class LabelValue extends StatelessWidget {

  final String label;
  final String? value;

  const LabelValue(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Label(label),
          Expanded(
              flex: 3,
              child: Text(
                value??"",
                style: Theme.of(context).textTheme.bodyText2,
              ))
        ],
      ),
    );
  }
}