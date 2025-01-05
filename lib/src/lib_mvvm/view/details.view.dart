import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/widgets/base_wrapper.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/streamings.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/view_model/details.viewmodel.dart";
import "package:movie_night_tcc/src/shared/components/ui_button.dart";
import "package:movie_night_tcc/src/shared/components/ui_image.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";

part "widgets/details.widgets.dart";

class DetailsView extends StatefulWidget {
  final String movieId;
  final MovieModel? movie;
  final DetailsViewmodel viewModel = DetailsViewmodel();
  final navigation = locator.get<INavigation>();

  DetailsView({
    required this.movieId,
    this.movie,
    super.key,
  });

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getStreamings(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      appBar: _DetailsAppBar(onTap: widget.navigation.pop),
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.movie?.title ?? widget.movieId,
                    style: AppFonts.robotoTitleBigBold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),
                  _DetailMovieBanner(
                    movie: widget.movie ?? MovieModel.empty(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 8,
                      children: widget.movie?.genres
                              .map(
                                (genre) => _GenreTag(label: genre.label),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.viewModel.detailsState.streamings.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: _StreamingsListWidget(
                        streamings: widget.viewModel.detailsState.streamings,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.details.synopsis,
                        style: AppFonts.robotoTitleBigMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.movie?.synopsis ?? "Description",
                        style: AppFonts.robotoTextSmallRegular,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StreamingsListWidget extends StatelessWidget {
  final StreamingsList streamings;

  const _StreamingsListWidget({
    required this.streamings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...streamings.flatrate.map(
                  (streaming) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _StreamingIcon(
                      imageUrl: streaming.imageUrl,
                    ),
                  ),
                ),
                ...streamings.rent.map(
                  (streaming) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _StreamingIcon(
                      imageUrl: streaming.imageUrl,
                      dotColor: AppColors.yellow,
                    ),
                  ),
                ),
                ...streamings.buy.map(
                  (streaming) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _StreamingIcon(
                      imageUrl: streaming.imageUrl,
                      dotColor: AppColors.cyan,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              AppStrings.details.subtitles,
              style: AppFonts.robotoTextSmallBold,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.yellow,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              AppStrings.details.toRent,
              style: AppFonts.robotoTextSmallBold,
            ),
            const SizedBox(width: 12),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.cyan,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              AppStrings.details.toBuy,
              style: AppFonts.robotoTextSmallBold,
            ),
          ],
        ),
      ],
    );
  }
}
