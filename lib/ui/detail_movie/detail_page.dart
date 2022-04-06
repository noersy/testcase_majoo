import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/services/api_service.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "Action not set");
                    },
                    child: SafeArea(child: const Icon(Icons.play_arrow_outlined, size: 55.0, color: Colors.yellow)),
                  )
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
                          onPressed: () {
                            Fluttertoast.showToast(msg: "Action not set");
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Fluttertoast.showToast(msg: "Action not set");
                          },
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
              SizedBox(height: SpDims.sp12),
              FutureBuilder<Movie>(
                future: apiServices.getMovieRecommendations(data.id),
                builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
                  final _data = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      child: spinKit,
                    );
                  }

                  if (_data.results?.isNotEmpty ?? false) {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: SpDims.sp2,
                        mainAxisSpacing: SpDims.sp2
                      ),
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
                            padding: const EdgeInsets.symmetric(
                              vertical: SpDims.sp2,
                              horizontal: SpDims.sp4,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 230,
                                  width: double.infinity,
                                  child: Card(
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
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
                                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
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
                    return Container(
                      height: 60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: SpDims.sp8),
                      child: Text(
                        "none",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
