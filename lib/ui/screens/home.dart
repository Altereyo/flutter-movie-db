import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/ui/theme/app_colors.dart';
import 'package:flutter_movie_db/bloc/movie/movie_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => MovieBloc()..add(MovieInitialEvent()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarWithSearchSwitch(
              backgroundColor: AppColors.containerColor,
              foregroundColor: AppColors.accentColor,
              onClosed: () {
                context.read<MovieBloc>().add(SearchClosedEvent());
              },
              clearOnSubmit: false,
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  context.read<MovieBloc>().add(SearchInputEvent(text));
                }
              },
              appBarBuilder: (context) {
                return AppBar(
                  title: Text(state.searchInput.isEmpty ? 'IMDB movies' : 'Search by "${state.searchInput}"'),
                  actions: [
                    if (state.isSearching) IconButton(
                      color: AppColors.textColor,
                      icon: const Icon(Icons.close),
                      onPressed: AppBarWithSearchSwitch.of(context)?.onClosed,
                    ),
                    IconButton(
                      color: AppColors.textColor,
                      icon: const Icon(Icons.search),
                      onPressed:
                          AppBarWithSearchSwitch.of(context)?.startSearch,
                    ),
                  ],
                );
              },
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.textColor,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Builder(builder: (_) {
                        final List<Widget> movies =
                            _renderMovies(context, state, (movie) => context.read<MovieBloc>().add(ClickMovieEvent(movie)));
                        if (movies.isNotEmpty) {
                          movies.add(ElevatedButton(
                            onPressed: () =>
                                context.read<MovieBloc>().add(ShowMoreEvent()),
                            child: const Text('Show more'),
                          ));
                        }
                        return Column(children: movies);
                      }),
                    ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _renderMovies(context, state, onTap) {
    final isSearching = state.isSearching && state.searchInput.isNotEmpty;
    final moviesList = isSearching ? state.searchList : state.movieList;

    if (moviesList.isEmpty) {
      return [
        Center(
          child: CircularProgressIndicator(
            color: AppColors.accentColor,
          ),
        )
      ];
    }

    final maxMovieCount = moviesList.length >= state.maxMovieCount
        ? state.maxMovieCount
        : moviesList.length;

    return moviesList.getRange(0, maxMovieCount).map<Widget>((movie) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GestureDetector(
          onTap: () => onTap(movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerColor,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 127,
                      child: Image.network(
                        movie.image!,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                        errorBuilder: (context, error, stackTrace) => Placeholder(
                          color: AppColors.accentColor,
                        ),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 180,
                            width: 127,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.accentColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              isSearching
                                  ? movie.title
                                  : '${movie.rank}. ${movie.title!}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppColors.accentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            if (!isSearching)
                              Text(
                                movie.crew!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            const Spacer(),
                            isSearching
                                ? Text(
                                    movie.description,
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        movie.imDbRating,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 22,
                                        color: AppColors.accentColor,
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
