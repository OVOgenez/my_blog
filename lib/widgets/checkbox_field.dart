import 'package:flutter/material.dart';

class CheckboxField extends StatefulWidget {
  final String title;

  const CheckboxField({Key key, this.title}) : super(key: key);

  @override
  _CheckboxFieldState createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(widget.title)),
          Checkbox(
            activeColor: Theme.of(context).colorScheme.primary,
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = !checked;
              });
            },
          ),
        ],
      ),
      onPressed: () {
        setState(() {
          checked = !checked;
        });
      },
    );
  }
}
