import 'package:bloc_clean_architecture/Utiles/enumes.dart';
import 'package:bloc_clean_architecture/bloc/movies_bloc/bloc/movie_bloc_bloc.dart';
import 'package:bloc_clean_architecture/config/components/Internet_exception.dart';
import 'package:bloc_clean_architecture/config/routes/routes_name.dart';
import 'package:bloc_clean_architecture/repository/movie/movies_http_api_repository.dart';
import 'package:bloc_clean_architecture/services/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBlocBloc movieBlocBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the MovieBlocBloc
    movieBlocBloc = MovieBlocBloc(moviesRepository: MoviesHttpApiRepository());
    // No need to add the MovieFetched event here as it's done in BlocProvider
  }

  @override
  void dispose() {
    movieBlocBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                LocalStorage localStorage = LocalStorage();
                localStorage.clearValue('token').then((value) {
                  localStorage.clearValue('isLogin').then((value) {
                    Navigator.pushNamed(context, RoutesName.loginscreen);
                  });
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocProvider(
        create: (context) => movieBlocBloc..add(MovieFetched()),
        child: BlocBuilder<MovieBlocBloc, MovieBlocState>(
          builder: (BuildContext context, state) {
            if (state.movieList.status == null) {
              // Handle null case for status
              return const Center(child: Text('Status is null'));
            }

            switch (state.movieList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                if (state.movieList.message == "No internet Connection") {
                  return InterNetExceptionWidget(
                    onPress: () {
                      movieBlocBloc.add(MovieFetched());
                    },
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }

              case Status.completed:
                if (state.movieList.data == null) {
                  // Show a "No Data Found" message if the data is null
                  return const Center(child: Text('No data found'));
                }

                final movieList = state.movieList.data!;
                return ListView.builder(
                  itemCount: movieList.tvShows!.length,
                  itemBuilder: (context, index) {
                    final tvShow = movieList.tvShows![index];
                    return Card(
                      child: ListTile(
                        leading: Image(
                          image: NetworkImage(
                            tvShow.imageThumbnailPath.toString(),
                          ),
                        ), // Widget for displaying network image
                        title: Text(
                            tvShow.name.toString()), // Title of the TV show
                        subtitle: Text(
                            tvShow.network.toString()), // Network of the show
                        trailing: Text(
                            tvShow.status.toString()), // Status of the show
                      ),
                    );
                  },
                );

              default:
                return const Center(child: Text('Unhandled status'));
            }
          },
        ),
      ),
    );
  }
}
