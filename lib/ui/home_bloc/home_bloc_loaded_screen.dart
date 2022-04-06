import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/app_bar.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/themes/spacing.dart';
import 'package:majootestcase/ui/detail_movie/detail_page.dart';
import 'package:majootestcase/ui/login/login_page.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final Trending data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data = this.data.results;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CAppBar(
        title: "Testcase",
        actionCallBack: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      drawer: Drawer(
        semanticLabel: "Menu",

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Logout',
                onPressed: (){

                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
              child: Text(
                "Trending",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            const SizedBox(height: 18.0),
            _TrendingCarousel(data: data),
          ],
        ),
      ),
    );
  }
}

class _TrendingCarousel extends StatelessWidget {
  final List<Result> data;

  const _TrendingCarousel({Key key, @required this.data}) : super(key: key);

  static const _imagePath = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
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
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: CImage.network(_imagePath + data[index].posterPath),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                  width: double.infinity,
                  child: Text(
                    data[index].title ?? data[index].name ?? data[index].originalTitle ?? data[index].originalName,
                    style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 340,
        viewportFraction: 0.5,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
