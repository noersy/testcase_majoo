import 'package:flutter/material.dart';

class CostumButton extends StatelessWidget {
  final String text;
  final double height;
  final VoidCallback onPressed;
  final Widget leadingIcon;
  final OutlinedBorder shapeBorder;
  final bool isSecondary;
  final bool isOutline;

  const CostumButton({
    Key key,
    @required this.text,
    this.height = 40,
    this.onPressed,
    this.leadingIcon,
    this.shapeBorder,
    this.isSecondary = false,
  })  : isOutline = false,
        super(key: key);

  const CostumButton.outline(
      {Key key, this.text, this.height = 40, this.onPressed, this.leadingIcon, this.shapeBorder, this.isSecondary = false})
      : isOutline = true,
        super(key: key);

  OutlinedBorder _shapeBorder(BuildContext context) =>
      shapeBorder ??
      RoundedRectangleBorder(
        side: isSecondary
            ? BorderSide(
                color: Theme.of(context).unselectedWidgetColor,
                width: 1,
                style: BorderStyle.solid,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      );

  Widget _label(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(color: _color(context)),
      ),
    );
  }

  Color _color(BuildContext context) {
    return Theme.of(context).buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final color = isSecondary ? Theme.of(context).unselectedWidgetColor : primaryColor;
    return ButtonTheme(
      height: height,
      buttonColor: color,
      minWidth: double.infinity,
      child: isOutline
          ? OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: _shapeBorder(context),
              ).copyWith(
                  side: MaterialStateProperty.all(BorderSide(
                color: _color(context),
                width: 2,
              ))),
              icon: leadingIcon ?? const SizedBox(),
              label: _label(context),
              onPressed: onPressed,
            )
          : TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: color,
                shape: _shapeBorder(context),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onSurface: Colors.grey,
              ),
              icon: leadingIcon ?? const SizedBox(),
              label: _label(context),
              onPressed: onPressed,
            ),
    );
  }
}
