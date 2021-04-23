/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/resources/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final String hintText;
  final String placeholder;
  final String counterText;
  final String helperText;
  final TextInputType textInputType;
  final int numberOfLine;
  final String initialValue;
  final bool obscureText;
  final Function() onTap;
  final Widget prefix;
  final Function(String) onChanged;
  final Function(String) onSaved;
  final EdgeInsets padding;
  final bool filled;
  final bool alignLabelWithHint;
  final IconData suffixIcon;
  final int maxLength;
  final double size;

  TextFieldWidget({
    this.validator,
    this.hintText,
    this.textInputType,
    this.numberOfLine = 1,
    this.placeholder,
    this.onChanged,
    this.initialValue,
    this.helperText,
    this.obscureText = false,
    this.onTap,
    this.prefix,
    this.counterText,
    this.filled,
    this.padding,
    this.maxLength,
    this.suffixIcon,
    this.alignLabelWithHint = true,
    this.onSaved,
    this.size,
  }) {
    controller.text = initialValue;
  }
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      // key: UniqueKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hintText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              hintText,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: MyColors.textColor,
              ),
            ),
          ),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -3,
            // boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: prefix != null || suffixIcon != null ? 4 : 16),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: onTap,
            decoration: InputDecoration(
              filled: filled,
              prefixIcon: prefix,
              suffixIcon: suffixIcon != null
                  ? Icon(
                      suffixIcon,
                    )
                  : null,
              isCollapsed: true,
              labelText: placeholder,
              counterText: counterText,
              helperText: helperText,
              hintText: placeholder,
              fillColor: Colors.white,
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: MyColors.primary,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              alignLabelWithHint: alignLabelWithHint,
            ),
            maxLines: numberOfLine,
            style: TextStyle(
              fontSize: size ?? 18,
            ),
            maxLength: maxLength,
            textAlignVertical: TextAlignVertical.center,
            obscureText: obscureText,
            controller: controller
              ..selection = TextSelection(
                baseOffset: controller.text.length,
                extentOffset: controller.text.length,
              ),
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            keyboardType: textInputType ?? TextInputType.text,
          ),
        ),
      ],
    );
  }
}
