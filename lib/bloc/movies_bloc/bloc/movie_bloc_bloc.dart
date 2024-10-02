import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/data/response/api_response.dart';
import 'package:bloc_clean_architecture/models/movie/movie_model.dart';
import 'package:bloc_clean_architecture/repository/movie/movies_http_api_repository.dart';
import 'package:bloc_clean_architecture/repository/movie/movies_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_bloc_event.dart';
part 'movie_bloc_state.dart';

// class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
//   MoviesRepository moviesRepository = MoviesHttpApiRepository();
//   MovieBlocBloc(required this.moviesRepository) : super(MovieBlocState(movieList: ApiResponse.loading())) {
//     on<MovieBlocEvent>((event, emit) {
//       // TODO: implement event handler
//       on<MovieFetched>(fetchMoviesListapi);
//     });

//     Future<void> fetchMoviesListapi (MovieFetched event , Emitter<MovieBlocState>  emit)async{

//     }
//   }
// }
class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final MoviesRepository moviesRepository;

  MovieBlocBloc({required this.moviesRepository})
      : super(MovieBlocState(movieList: ApiResponse.loading())) {
    // Register the event handler for MovieFetched
    on<MovieFetched>(fetchMoviesListapi);
  }

  Future<void> fetchMoviesListapi(
      MovieFetched event, Emitter<MovieBlocState> emit) async {
    await moviesRepository.fetchMoviesList().then((value) {
      emit(state.copyWith(movieList: ApiResponse.completed(value)));
    }).onError(
      (error, stackTrace) {
        emit(state.copyWith(movieList: ApiResponse.error(error.toString())));
      },
    );
    // try {
    //   emit(MovieBlocState(movieList: ApiResponse.loading()));
    //   final moviesList = await moviesRepository.fetchMoviesList();
    //   emit(MovieBlocState(movieList: ApiResponse.completed(moviesList)));
    // } catch (e) {
    //   emit(MovieBlocState(movieList: ApiResponse.error(e.toString())));
    // }
  }
}
