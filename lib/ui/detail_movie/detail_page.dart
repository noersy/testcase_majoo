import 'package:flutter/material.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/themes/spacing.dart';

class DetailMoviePage extends StatelessWidget {
  final Result data;
  final String title;

  const DetailMoviePage({Key key, @required this.data, @required this.title}) : super(key: key);

  static const _imagePath = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Theme.of(context).primaryColor, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      image: NetworkImage(_imagePath + data.posterPath),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              SafeArea(child: const Icon(Icons.play_arrow_outlined, size: 55.0, color: Colors.yellow))
            ],
          ),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: SpDims.sp18, vertical: SpDims.sp18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text("Release: ${data.releaseDate.year}"),
                      padding: const EdgeInsets.symmetric(vertical: SpDims.sp2, horizontal: SpDims.sp4),
                      margin: const EdgeInsets.symmetric(horizontal: SpDims.sp8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.addchart, color: Colors.green, size: 16.0),
                          SizedBox(width: SpDims.sp2),
                          Text("${data.popularity}"),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: SpDims.sp2, horizontal: SpDims.sp4),
                      margin: const EdgeInsets.symmetric(horizontal: SpDims.sp8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 13.0),
                          SizedBox(width: SpDims.sp2),
                          Text("${data.voteAverage}"),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: SpDims.sp8),
                      padding: const EdgeInsets.symmetric(vertical: SpDims.sp2, horizontal: SpDims.sp4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: SpDims.sp18, vertical: SpDims.sp18),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.title),
                  SizedBox(height: SpDims.sp20),
                  Text(data.overview),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
