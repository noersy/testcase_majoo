
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback actionCallBack;
  const CAppBar({Key key, @required this.title, this.actionCallBack}) : super(key: key);

  @override
  Size get preferredSize => const Size(0, 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: "Action not set");
          },
        ),
      ],
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.list),
        onPressed: actionCallBack,
      ),
    );
  }
}