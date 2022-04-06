import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/main.dart';
import 'package:majootestcase/themes/spacing.dart';

class CostumeAlertDialog extends StatelessWidget {
  final String title, content;
  final bool isError;

  const CostumeAlertDialog({Key key, @required this.title, @required this.content, @required this.isError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lottie = "";
    if (isError)  lottie = "asserts/lottie/error.json";
    else lottie = "asserts/lottie/correct.json";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(lottie, height: 120, width: 120, repeat: false),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: SpDims.sp12),
          content.isNotEmpty ? LimitedBox(
            maxHeight: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpDims.sp46, vertical: SpDims.sp12),
              child: Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ) : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(bottom: SpDims.sp12, top: SpDims.sp4),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(horizontal: SpDims.sp46),
                primary: Theme.of(context).buttonColor,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text("OK"),
              onPressed: () => navigatorKey.currentState.pop(),
            ),
          )
        ],
      ),
    );
  }
}
