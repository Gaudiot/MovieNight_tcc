import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/movie.entity.dart";
import "package:movie_night_tcc/src/lib_feature/watchlist/watchlist.viewmodel.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/widgets/movie_poster.dart";
import "package:movie_night_tcc/src/shared/components/components.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";

class WatchlistView extends StatefulWidget {
  final WatchlistViewmodel viewModel = WatchlistViewmodel();

  WatchlistView({super.key});

  @override
  State<WatchlistView> createState() => _WatchlistViewState();
}

class _WatchlistViewState extends State<WatchlistView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getMovies();
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
              _WatchlistHeader(viewModel: widget.viewModel),
              const SizedBox(height: 12),
              _WatchlistContent(viewModel: widget.viewModel),
            ],
          ),
        );
      },
    );
  }
}

class _WatchlistHeader extends StatelessWidget {
  final WatchlistViewmodel viewModel;

  const _WatchlistHeader({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UISearchBar(
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
          hintText: AppStrings.generic.searchMovies,
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
              AppStrings.watchlist,
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

class _WatchlistContent extends StatelessWidget {
  final WatchlistViewmodel viewModel;

  const _WatchlistContent({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Expanded(child: _LoadingMovieList());
    }

    if (viewModel.movies.isEmpty) {
      return const _EmptyMovieList();
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: viewModel.movies.length,
        itemBuilder: (context, index) => _WatchlistMovieTile(
          movie: viewModel.movies[index],
          onMovieWatched: () =>
              viewModel.onMovieWatched(movieId: viewModel.movies[index].id),
          onMovieRemoved: () =>
              viewModel.onMovieRemoved(movieId: viewModel.movies[index].id),
        ),
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

class _WatchlistMovieTile extends StatelessWidget {
  final MovieModel movie;

  final VoidCallback onMovieWatched;
  final VoidCallback onMovieRemoved;

  const _WatchlistMovieTile({
    required this.movie,
    required this.onMovieWatched,
    required this.onMovieRemoved,
  });

  String get _releaseYear => TimeUtils.dateTimeToYear(movie.releaseDate);
  String get _runtimeFormatted => TimeUtils.intToRuntime(movie.runtime);

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: AppFonts.robotoTitleSmallMedium,
                  maxLines: 2,
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
                      .map(
                        (genre) => Text(
                          MovieGenre.fromId(genre.id).label,
                          style: AppFonts.robotoTextSmallRegular.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      )
                      .toList(),
                ),
                _MovieCardButton(
                  label: AppStrings.action.addToWatched,
                  icon: const Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: AppColors.yellow,
                  ),
                  onTap: onMovieWatched,
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: UIButton(
              onTap: onMovieRemoved,
              child: Assets.lib.assets.icTrashOutline.svg(
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
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
          AppStrings.generic.loadingMovies,
          style: AppFonts.robotoTitleBigMedium,
        ),
      ],
    );
  }
}

class _EmptyMovieList extends StatelessWidget {
  const _EmptyMovieList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.lib.assets.emptyPopcorn.svg(),
          const SizedBox(height: 26),
          Text(
            AppStrings.generic.emptyList,
            style: AppFonts.robotoTitleBigMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
