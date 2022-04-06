import 'package:flutter/material.dart';
import 'package:majootestcase/common/widget/app_bar.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/ui/extra/movie_list.dart';
import 'package:majootestcase/ui/extra/side_menu.dart';
import 'package:majootestcase/ui/extra/trending_carousel.dart';
import 'package:majootestcase/ui/extra/upcoming_list.dart';
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
      drawer: SideMenu(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SpDims.sp18),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
                  child: Text(
                    "Trending",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                const SizedBox(height: SpDims.sp18),
                TrendingCarousel(data: widget.data[0].results),
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
                  child: UpcomingList(data: widget.data[1].results),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: SpDims.sp18),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpDims.sp4, horizontal: SpDims.sp4),
                  child: Text(
                    "List Movie",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                LimitedBox(
                  maxHeight: 1000,
                  child: MovieList(data: widget.data[1].results),
                ),
              ],
            ),
          ),
        ],
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
