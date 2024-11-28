import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/lib_feature/watched/watched.viewmodel.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/widgets/movie_banner.dart";
import "package:movie_night_tcc/src/shared/components/components.dart";

class WatchedView extends StatefulWidget {
  final WatchedViewmodel viewModel = WatchedViewmodel();

  WatchedView({super.key});

  @override
  State<WatchedView> createState() => _WatchedViewState();
}

class _WatchedViewState extends State<WatchedView> {
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
              _WatchedHeader(viewModel: widget.viewModel),
              const SizedBox(height: 12),
              _WatchedContent(viewModel: widget.viewModel),
            ],
          ),
        );
      },
    );
  }
}

class _WatchedHeader extends StatelessWidget {
  final WatchedViewmodel viewModel;

  const _WatchedHeader({required this.viewModel});

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
          children: [
            Text(
              AppStrings.watched,
              style: AppFonts.robotoTitleBigMedium,
            ),
            const Spacer(),
            _FavoriteToggle(
              onToggleFavorite: viewModel.onToggleFilterFavorite,
              isSelected: viewModel.filterFavorite,
            ),
            const SizedBox(width: 8),
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

class _WatchedContent extends StatelessWidget {
  final WatchedViewmodel viewModel;

  const _WatchedContent({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Expanded(child: _LoadingMovieList());
    }

    if (viewModel.movies.isEmpty) {
      return const _EmptyMovieList();
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: viewModel.movies.length,
        itemBuilder: (_, index) {
          final movie = viewModel.movies[index];

          return MovieBanner(
            backdropUrl: movie.backdropUrl!,
            rating: movie.rating,
            isFavorite: movie.favorite,
            onRemove: () => viewModel.onMovieRemoved(movieId: movie.id),
            onToggleFavorite: () => viewModel.onMovieFavorite(
              movieId: movie.id,
              isFavorite: movie.favorite,
            ),
          );
        },
      ),
    );
  }
}

class _FavoriteToggle extends StatelessWidget {
  final VoidCallback onToggleFavorite;
  final bool isSelected;

  const _FavoriteToggle({
    required this.onToggleFavorite,
    this.isSelected = false,
  });

  Color get color => isSelected ? AppColors.yellow : AppColors.white;

  @override
  Widget build(BuildContext context) {
    return UIButton(
      inkwellOpacity: 0,
      onTap: onToggleFavorite,
      child: Container(
        height: 35,
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              width: 1,
              color: color,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              AppStrings.favorites,
              style: AppFonts.robotoTextSmallRegular.copyWith(
                color: color,
              ),
            ),
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
