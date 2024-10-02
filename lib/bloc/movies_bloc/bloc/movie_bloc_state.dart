part of 'movie_bloc_bloc.dart';

class MovieBlocState extends Equatable {
  const MovieBlocState({
    required this.movieList,
  });

  final ApiResponse<MovieModal>
      movieList; // api response and movie modal we hve created

  MovieBlocState copyWith({
    ApiResponse<MovieModal>? movieList,
  }) {
    return MovieBlocState(
      movieList: movieList ?? this.movieList,
    );
  }

  @override
  List<Object> get props => [movieList];
}
