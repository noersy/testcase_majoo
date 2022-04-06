
import 'package:flutter/material.dart';
import 'package:majootestcase/common/widget/image_network.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/ui/detail_movie/detail_page.dart';
import 'package:majootestcase/utils/constant.dart';

class UpcomingList extends StatelessWidget {
  final List<Result> data;

  const UpcomingList({Key key, this.data}) : super(key: key);

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
                  width: 120.0,
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
