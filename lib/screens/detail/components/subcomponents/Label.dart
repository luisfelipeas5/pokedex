import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Label extends StatelessWidget {

  final String label;

  const Label(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Theme.of(context).hintColor.withAlpha(100)
        ),
      ),
    );
  }
}