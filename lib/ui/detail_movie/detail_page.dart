import 'package:flutter/material.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/services/api_service.dart';
import 'package:majootestcase/themes/spacing.dart';
import 'package:majootestcase/utils/constant.dart';

class DetailMoviePage extends StatelessWidget {
  final Result data;
  final String title;

  const DetailMoviePage({Key key, @required this.data, @required this.title}) : super(key: key);

  static ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
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
                        image: NetworkImage(Api.imagePath + data.posterPath),
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
                        child: Text(
                          "${data.releaseDate?.year}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
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
                            Icon(Icons.addchart, color: Colors.green, size: 16.0),
                            SizedBox(width: SpDims.sp2),
                            Text(
                              "${data.popularity}",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
                            ),
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
                            Text(
                              "${data.voteAverage}",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
                            ),
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
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: SpDims.sp18, vertical: SpDims.sp18),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.title.copyWith(color: Colors.white)),
                  SizedBox(height: SpDims.sp20),
                  Text(data.overview, style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recommendations",
                style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
              ),
            ),
            FutureBuilder<Movie>(
              future: apiServices.getMovieRecommendations(data.id),
              builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
                final _data = snapshot.data;
                if (_data != null) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4 / 6),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _data.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = _data.results;
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailMoviePage(
                              data: data[index],
                              title: data[index].title ?? data[index].name ?? data[index].originalTitle ?? data[index].originalName,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Card(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: CImage.network(Api.imagePath + data[index].posterPath, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                                  child: Text(
                                    data[index]?.title ?? data[index]?.name ?? data[index].originalTitle ?? data[index]?.originalName,
                                    style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
