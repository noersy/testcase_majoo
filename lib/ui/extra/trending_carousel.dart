import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/ui/detail_movie/detail_page.dart';

class TrendingCarousel extends StatelessWidget {
  final List<Result> data;

  const TrendingCarousel({Key key, @required this.data}) : super(key: key);

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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: CImage.network(_imagePath + data[index].posterPath),
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
