import 'package:bloc_clean_architecture/config/AppUrl/app_url.dart';
import 'package:bloc_clean_architecture/data/network/network_api_services.dart';
import 'package:bloc_clean_architecture/models/movie/movie_model.dart';
import 'package:bloc_clean_architecture/repository/movie/movies_repository.dart';

class MoviesHttpApiRepository implements MoviesRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<MovieModal> fetchMoviesList() async {
    final response = await _apiServices.getApi(AppUrl.popularMovieListEndPoint);
    return MovieModal.fromJson(response);
  }
}
