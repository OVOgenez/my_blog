import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final bool passwordMod;

  const InputField({Key key, this.labelText, this.passwordMod = false})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidePassword, //This will obscure text dynamically
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.labelText,
        suffixIcon: widget.passwordMod
            ? IconButton(
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}
