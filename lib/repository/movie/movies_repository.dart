import 'package:bloc_clean_architecture/models/movie/movie_model.dart';

abstract class MoviesRepository {
  Future<MovieModal>
      fetchMoviesList(); // here we write function fetchmovielist that returns movie modal
}
