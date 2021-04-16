/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';

class DropDownWidget<T> extends StatefulWidget {
  Map<String, T> items;
  String placeHolder;
  String selected;
  Function(String, T) onChanged;
  final FormFieldValidator<String> validator;

  bool isExpanded;
  DropDownWidget({
    @required this.items,
    this.selected,
    this.onChanged,
    this.isExpanded = true,
    @required this.placeHolder,
    this.validator,
  });

  @override
  _DropDownWidgetState<T> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonFormField(
          isExpanded: widget.isExpanded,
          items: widget.items.keys
              .map(
                (e) => DropdownMenuItem(
                  child: LabelWidget(e),
                  value: e,
                ),
              )
              .toList(),
          value: widget.selected,
          dropdownColor: MyColors.neuBackground,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: LabelWidget(
            widget.placeHolder,
          ),
          onChanged: (String val) {
            setState(() {
              widget.onChanged?.call(val, widget.items[val]);
              widget.selected = val;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
