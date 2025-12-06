import 'package:flutter/material.dart';

class InputCustomCore extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final String? label;
  final String? hintText;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final String? title;
  final Widget? suffixWidget;
  final VoidCallback? suffixIconOnTap;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final bool outTapEnabled;
  const InputCustomCore({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.label,
    this.hintText,
    this.readOnly = false,
    this.textInputType,
    this.borderRadius,
    this.contentPadding,
    this.suffixWidget,
    this.suffixIconOnTap,
    this.suffixIcon,
    this.focusNode,
    this.maxLines,
    this.textInputAction,
    this.isEnabled = true,
    this.validator,
    this.title,
    this.prefixWidget,
    this.outTapEnabled = false,
  });

  @override
  State<InputCustomCore> createState() => _InputCustomCoreState();
}

class _InputCustomCoreState extends State<InputCustomCore> {
  late FocusNode _focusNode;
  bool isActive = false;
  late bool obscureText;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isActive = _focusNode.hasFocus;
      });
    });
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Column(
      crossAxisAlignment: .start,
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: themedata.textTheme.titleSmall),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          readOnly: widget.readOnly,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          minLines: 1,
          maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,
          onTapOutside: (event) {
            if (widget.outTapEnabled) {
              _focusNode.unfocus();
            }
          },
          obscureText: obscureText,
          enabled: widget.isEnabled,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 25),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: obscureText
                        ? Icon(
                            Icons.visibility,
                            color: isActive
                                ? themedata.colorScheme.primary
                                : themedata.colorScheme.secondary,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: isActive
                                ? themedata.colorScheme.primary
                                : themedata.colorScheme.secondary,
                          ),
                  )
                : widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.suffixIconOnTap,
                    child: Icon(
                      widget.suffixIcon,
                      color: isActive
                          ? themedata.colorScheme.primary
                          : themedata.colorScheme.secondary,
                    ),
                  )
                : widget.suffixWidget,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
              borderSide: BorderSide(color: themedata.colorScheme.onSecondary),
            ),
            hintText: widget.hintText,
            hintStyle: themedata.textTheme.bodyMedium?.copyWith(
              color: themedata.colorScheme.secondary,
            ),
            labelText: widget.label,
            labelStyle: themedata.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: isActive
                  ? themedata.colorScheme.primary
                  : themedata.colorScheme.secondary,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: isActive
                        ? themedata.colorScheme.primary
                        : themedata.colorScheme.secondary,
                  )
                : widget.prefixWidget,
          ),
        ),
      ],
    );
  }
}
