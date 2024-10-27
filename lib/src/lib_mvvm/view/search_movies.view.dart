import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/search_movie.model.dart";
import "package:movie_night_tcc/src/lib_mvvm/view_model/search_movies.viewmodel.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";
import "package:movie_night_tcc/src/shared/widgets/movie_poster.dart";
import "package:movie_night_tcc/src/shared/widgets/ui_button.dart";
import "package:movie_night_tcc/src/shared/widgets/ui_dropdown.dart";
import "package:movie_night_tcc/src/shared/widgets/ui_search_bar.dart";

class SearchMoviesView extends StatelessWidget {
  final SearchMoviesViewmodel viewModel = SearchMoviesViewmodel();

  SearchMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.movies.isEmpty) {
          viewModel.fetchMovies();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              UISearchBar.delayed(
                suffixEmptyIcon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
                suffixIcon: const Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
                height: 40,
                backgroundColor: AppColors.darkBlue,
                onChanged: (value) => viewModel.updateQueryTitle(title: value),
                hintText: AppStrings.searchMovies,
                hintStyle: AppFonts.robotoTextSmallRegular.copyWith(
                  color: AppColors.white.withOpacity(0.5),
                ),
                textStyle: AppFonts.robotoTextSmallRegular.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (viewModel.queryTitle.isEmpty)
                        ? AppStrings.trending
                        : AppStrings.search,
                    style: AppFonts.robotoTitleBigMedium,
                  ),
                  UIDropdownMovies(
                    value: viewModel.queryGenre,
                    onChanged: (genre) =>
                        viewModel.onUpdateMovieGenre(movieGenre: genre),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (viewModel.isLoading && viewModel.movies.isEmpty)
                const Expanded(child: _LoadingMovieList())
              else if (viewModel.movies.isEmpty)
                const _EmptySearchMovies()
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: viewModel.movies.length,
                    itemBuilder: (_, index) {
                      if (index == viewModel.movies.length - 5) {
                        viewModel.fetchMovies();
                      }
                      final movie = viewModel.movies[index].movie;

                      return _MovieTile(
                        searchMovie: viewModel.movies[index],
                        onMovieWatchlist: () =>
                            viewModel.onMovieWatchlist(movieId: movie.id),
                        onMovieWatched: () =>
                            viewModel.onMovieWatched(movieId: movie.id),
                      );
                    },
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Divider(
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _MovieTile extends StatelessWidget {
  final SearchMovieModel searchMovie;

  final VoidCallback onMovieWatchlist;
  final VoidCallback onMovieWatched;

  const _MovieTile({
    required this.searchMovie,
    required this.onMovieWatchlist,
    required this.onMovieWatched,
  });

  String get _releaseYear => dateTimeToYear(searchMovie.movie.releaseDate);
  String get _runtimeFormatted => intToRuntime(searchMovie.movie.runtime);

  @override
  Widget build(BuildContext context) {
    final movie = searchMovie.movie;

    return SizedBox(
      height: 136,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviePoster(
            imageUrl: movie.posterUrl ?? "",
            rating: movie.rating,
          ),
          const SizedBox(width: 20),
          Expanded(
            // Adicionando Expanded para evitar overflow
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: AppFonts.robotoTitleSmallMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        _releaseYear,
                        style: AppFonts.robotoTextSmallRegular,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _runtimeFormatted,
                        style: AppFonts.robotoTextSmallRegular,
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 4,
                    children: movie.genres
                        .take(3)
                        .map(
                          (genre) => Text(
                            MovieGenre.fromId(genre.id).label,
                            style: AppFonts.robotoTextSmallRegular.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Row(
                    children: [
                      if (!searchMovie.isWatchlist &&
                          !searchMovie.isWatched) ...[
                        _MovieCardButton(
                          label: AppStrings.addToWatchlist,
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: AppColors.yellow,
                          ),
                          onTap: onMovieWatchlist,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Visibility(
                        visible: !searchMovie.isWatched,
                        child: _MovieCardButton(
                          label: AppStrings.addToWatched,
                          icon: const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: AppColors.yellow,
                          ),
                          onTap: onMovieWatched,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCardButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _MovieCardButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UIButton(
      onTap: onTap,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              color: AppColors.yellow,
              width: 1.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 10,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: AppFonts.robotoTextSmallBold.copyWith(
                  color: AppColors.yellow,
                ),
              ),
              const SizedBox(width: 4),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingMovieList extends StatelessWidget {
  const _LoadingMovieList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.lib.assets.tickets.image(),
        const SizedBox(height: 26),
        Text(
          AppStrings.loadingMovies,
          style: AppFonts.robotoTitleBigMedium,
        ),
      ],
    );
  }
}

class _EmptySearchMovies extends StatelessWidget {
  const _EmptySearchMovies();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.lib.assets.emptyPopcorn.svg(),
          const SizedBox(height: 26),
          Text(
            AppStrings.noMoviesFound,
            style: AppFonts.robotoTitleBigMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
