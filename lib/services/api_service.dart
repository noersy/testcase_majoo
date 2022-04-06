
import 'dart:async';

import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices{

  /// api untuk mengambil data list movie trending
  /// @auth Nur Syahfei
  ///
  /// @return Future<Movie> (bisa null) gunakan pengecekan untuk menggunakan
  Future<Movie> getMovieTrending() async {
    try {
      var dio = await dioConfig.dio();
      final response  = await dio.get("trending/all/day");
      return Movie.fromMap(response.data);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  /// api untuk mengambil data Upcoming movie
  /// @auth Nur Syahfei
  ///
  /// @return Future<Movie> (bisa null) gunakan pengecekan untuk menggunakan
  Future<Movie> getMovieUpcoming() async {
    try {
      var dio = await dioConfig.dio();
      final response  = await dio.get("/movie/upcoming");
      return Movie.fromMap(response.data);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  /// api untuk mengambil data list Movie Recommendations
  /// @auth Nur Syahfei
  ///
  /// @return Future<Movie> (bisa null) gunakan pengecekan untuk menggunakan
  Future<Movie> getMovieRecommendations(int id) async {
    try {
      var dio = await dioConfig.dio();
      final response  = await dio.get("/movie/$id/recommendations");
      return Movie.fromMap(response.data);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}