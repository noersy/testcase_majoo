import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_field.dart';

class CustomTextFormField extends CustomFormField<String> {
  CustomTextFormField({
    @required String label,
    @required String hint,
    @required TextController controller,
    BuildContext context,
    bool enabled = true,
    bool mandatory = true,
    bool isObscureText = false,
    FormFieldValidator<String> validator,
    double padding = 4,
    @required TextInputType textInputType,
    Key key,
  }) : super(
          key: key,
          controller: controller,
          enabled: enabled,
          builder: (FormFieldState<String> state) {
            return _CustomTextForm(
              label: label,
              controller: controller,
              hint: hint,
              state: state,
              mandatory: mandatory,
              isObscureText: isObscureText,
              padding: padding,
              textInputType: textInputType,
              validator: validator,
            );
          },
          validator: (picker) {
            if (mandatory && (picker == null || picker.isEmpty)) {
              return 'this field is required';
            }
            if (validator != null) {
              return validator(picker);
            }
            return null;
          },
        );
}

class TextController extends CustomFormFieldController<String> {
  TextController({String initialValue}) : super(initialValue);

  @override
  String fromValue(String value) => value;

  @override
  String toValue(String text) => text;
}

class _CustomTextForm extends StatefulWidget {
  final FormFieldState<String> state;
  final TextController controller;
  final double padding;
  final String label;
  final String hint;
  final bool mandatory;
  final bool isObscureText;
  final Widget suffixIcon;

  final TextInputType textInputType;
  final bool hideTitle;
  final TextInputAction action;
  final FormFieldValidator<String> validator;

  const _CustomTextForm({
    this.state,
    this.controller,
    this.label,
    this.padding = 0,
    this.isObscureText = false,
    this.mandatory = false,
    this.suffixIcon,
    @required this.hint,
    @required this.textInputType,
    this.hideTitle,
    this.action,
    @required this.validator,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<_CustomTextForm> {
  final _focusNode = FocusNode();

  String get _hint => widget.hint;
  bool isHide = true;

  bool get _mandatory => widget.mandatory;

  String get _label {
    var fullLabel = StringBuffer();
    final label = widget.label;
    if (label != null) {
      fullLabel.write(label);
      if (_mandatory) fullLabel.write(' *');
      return fullLabel.toString();
    }
    return label;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final _hint = this._hint;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding, top: widget.padding),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller.textController,
        keyboardType: widget.textInputType,
        onChanged: (value) => widget.controller.value = value,
        textInputAction: widget.action,
        inputFormatters: widget.textInputType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
        obscureText: widget.textInputType == TextInputType.visiblePassword && isHide ? true : false,
        validator: (picker) {
          if (widget.mandatory && (picker == null || picker.isEmpty)) {
            return 'Form tidak boleh kosong';
          }
          if (widget.validator != null) {
            return widget.validator(picker);
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: _hint,
          labelText: _label,
          suffix: GestureDetector(
            onTap: () {
              if ((widget.textInputType == TextInputType.visiblePassword)) {
                setState(() => isHide = !isHide);
              } else {
                widget.controller.textController.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                (widget.textInputType == TextInputType.visiblePassword)
                    ? (isHide ? Icons.visibility_off : Icons.visibility)
                    : Icons.cancel,
                color: isHide ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
              ),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).selectedRowColor),
          ),
        ),
      ),
    );
  }
}
