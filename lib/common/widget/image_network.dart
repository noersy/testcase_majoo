import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget onLoading(
    BuildContext context,
    Widget child,
    ImageChunkEvent loadingProgress,
    ) {
  if (loadingProgress != null) {
    return spinKit;
  } else {
    return child;
  }
}

Widget onError(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
    ) {
  debugPrint(error.toString());
  debugPrint(stackTrace.toString());
  return const Icon(Icons.image_not_supported_outlined);
}

final spinKit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);

class CImage {
  static Widget network(String src, {BoxFit fit}) {
    return Image.network(
      src,
      alignment: Alignment.topCenter,
      fit: fit,
      loadingBuilder: (_, __, ___) => onLoading(_, __, ___),
      errorBuilder: (_, __, ___) => onError(_, __, ___),
    );
  }
}
