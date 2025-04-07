import 'package:flutter/material.dart';
class CustomFormField extends StatefulWidget {
  final String title1;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function(String)? onChange;
  final bool suffixIcon;
  final bool isPassword;

  const CustomFormField({
    super.key,
    required this.title1,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.onChange,
    this.suffixIcon = false,
    this.isPassword = false,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.title1,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: (text) {
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon && widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
