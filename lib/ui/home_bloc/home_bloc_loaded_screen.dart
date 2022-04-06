import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/app_bar.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/themes/spacing.dart';
import 'package:majootestcase/ui/detail_movie/detail_page.dart';
import 'package:majootestcase/utils/constant.dart';

class HomeBlocLoadedScreen extends StatefulWidget {
  final List<Movie> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  _HomeBlocLoadedScreenState createState() => _HomeBlocLoadedScreenState();
}

class _HomeBlocLoadedScreenState extends State<HomeBlocLoadedScreen> {
  final PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CAppBar(
        title: "Movie App",
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
              child: CostumButton(
                text: 'Logout',
                onPressed: () {
                  BlocProvider.of<AuthBlocCubit>(context).logout();
                },
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          SingleChildScrollView(
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
                _TrendingCarousel(data: widget.data[0].results),
                SizedBox(height: SpDims.sp20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
                  child: Text(
                    "Upcoming",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                LimitedBox(
                  maxHeight: 300,
                  child: _UpcomingList(data: widget.data[1].results),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
                  child: Text(
                    "List Movie",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                LimitedBox(
                  maxHeight: 1000,
                  child: _MovieList(data: widget.data[1].results),
                ),
              ],
            ),
          ),
        ],
        onPageChanged: (value) {
          index = value;
        },
      ),
      bottomNavigationBar: StatefulBuilder(
        builder: (context, setState) {
          return BottomNavigationBar(
            currentIndex: index,
            items: [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(label: "List Movie", icon: Icon(Icons.video_collection_outlined)),
            ],
            onTap: (value) {
              controller.animateToPage(value, duration: Duration(milliseconds: 500), curve: Curves.ease);
              setState(() {
                index = value;
              });
            },
          );
        },
      ),
    );
  }
}

class _MovieList extends StatelessWidget {
  final List<Result> data;

  const _MovieList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2 / 4),
      itemCount: data.length,
      itemBuilder: (_, index) {
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
  }
}

class _UpcomingList extends StatelessWidget {
  final List<Result> data;

  const _UpcomingList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) {
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
