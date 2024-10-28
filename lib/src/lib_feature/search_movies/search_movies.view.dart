import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/search_movie.entity.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/search_movies.viewmodel.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";
import "package:movie_night_tcc/src/shared/widgets/components/components.dart";
import "package:movie_night_tcc/src/shared/widgets/movie_poster.dart";

class SearchMoviesView extends StatefulWidget {
  final SearchMoviesViewmodel viewModel = SearchMoviesViewmodel();

  SearchMoviesView({super.key});

  @override
  State<SearchMoviesView> createState() => _SearchMoviesViewState();
}

class _SearchMoviesViewState extends State<SearchMoviesView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _SearchMoviesHeader(viewModel: widget.viewModel),
              const SizedBox(height: 12),
              _SearchMoviesContent(viewModel: widget.viewModel),
            ],
          ),
        );
      },
    );
  }
}

class _SearchMoviesHeader extends StatelessWidget {
  final SearchMoviesViewmodel viewModel;

  const _SearchMoviesHeader({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onChanged: (value) => viewModel.onUpdateQueryTitle(title: value),
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
                  viewModel.onUpdateQueryGenre(movieGenre: genre),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchMoviesContent extends StatelessWidget {
  final SearchMoviesViewmodel viewModel;

  const _SearchMoviesContent({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading && viewModel.movies.isEmpty) {
      return const Expanded(child: _LoadingMovieList());
    }

    if (viewModel.movies.isEmpty) {
      return const _EmptySearchMovies();
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: viewModel.movies.length,
        itemBuilder: (_, index) {
          if (index == viewModel.movies.length - 5) {
            viewModel.fetchMovies();
          }
          final searchMovie = viewModel.movies[index];

          return _MovieTile(
            searchMovie: searchMovie,
            onMovieWatchlist: () =>
                viewModel.onMovieWatchlist(movieId: searchMovie.movie.id),
            onMovieWatched: () =>
                viewModel.onMovieWatched(movieId: searchMovie.movie.id),
          );
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 13),
          child: Divider(
            color: AppColors.gray,
          ),
        ),
      ),
    );
  }
}

class _MovieTile extends StatelessWidget {
  final SearchMovieEntity searchMovie;

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
