
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices{
  Future<Trending> getMovieList() async {
    try {
      var dio = await dioConfig.dio();
      final response  = await dio.get("");
      return Trending.fromMap(response.data);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}