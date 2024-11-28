import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/base/widgets/base_wrapper.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/core/extensions/list_extensions.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/main_genre_watched.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/view_model/profile.viewmodel.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";
import "package:movie_night_tcc/src/shared/widgets/components/components.dart";

part "widget/profile.widgets.dart";

class ProfileView extends StatefulWidget {
  final ProfileViewmodel viewModel = ProfileViewmodel();
  final navigation = locator.get<INavigation>();

  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      appBar: _ProfileAppBar(onTap: widget.navigation.pop),
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.profile.title,
                  style: AppFonts.robotoTitleBigMedium,
                ),
                const SizedBox(height: 20),
                _BasicContainer(
                  borderColor: AppColors.white,
                  child: _GeneralProfileInfo(
                    mainGenresWatched: widget.viewModel.mainGenresWatched,
                    totalMoviesWatched:
                        widget.viewModel.profileState.totalMoviesWatched,
                    watchedTimeInfo: widget.viewModel.getWatchedTimeInfo(),
                  ),
                ),
                const SizedBox(height: 16),
                _BasicContainer(
                  borderColor: AppColors.white,
                  child: _MainGenresWatched(
                    mainGenresWatched: widget.viewModel.mainGenresWatched,
                  ),
                ),
                const SizedBox(height: 32),
                UIButton(
                  onTap: widget.viewModel.deleteUserData,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: AppColors.red,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.profile.deleteMyData,
                        style: AppFonts.robotoTextSmallBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BasicContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const _BasicContainer({
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: child,
      ),
    );
  }
}

class _GeneralProfileInfo extends StatefulWidget {
  final List<MainGenreWatched> mainGenresWatched;
  final int totalMoviesWatched;
  final List<DateInfo> watchedTimeInfo;

  const _GeneralProfileInfo({
    required this.mainGenresWatched,
    required this.watchedTimeInfo,
    required this.totalMoviesWatched,
  });

  @override
  State<_GeneralProfileInfo> createState() => _GeneralProfileInfoState();
}

class _GeneralProfileInfoState extends State<_GeneralProfileInfo> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                selectedPage = index;
              });
            },
            children: [
              _TimeSpentWatching(watchedTimeInfo: widget.watchedTimeInfo),
              _TotalMoviesWatched(
                totalMoviesWatched: widget.totalMoviesWatched,
              ),
              _FavoriteGenre(
                genre: widget.mainGenresWatched.firstOrNull?.genre,
              ),
            ],
          ),
        ),
        PageIndicator(
          itemCount: 3,
          currentIndex: selectedPage,
        ),
      ],
    );
  }
}

class _MainGenresWatched extends StatelessWidget {
  final List<MainGenreWatched> mainGenresWatched;

  const _MainGenresWatched({
    required this.mainGenresWatched,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BaseHeader(
          icon: Assets.lib.assets.movieRollPiece.svg(),
          title: AppStrings.profile.mainGenresWatched,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Column(
                children: [
                  Text("", style: AppFonts.robotoTextSmallBold),
                  const SizedBox(height: 8),
                  ...List.generate(mainGenresWatched.length, (index) {
                    return Text(
                      "#${index + 1}",
                      style: AppFonts.robotoTextSmallRegular.copyWith(
                        color: AppColors.yellow,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Genre", style: AppFonts.robotoTextSmallMedium),
                    const SizedBox(height: 8),
                    ...mainGenresWatched.mapIndexed((index, mainGenre) {
                      return Text(
                        mainGenre.genre.label,
                        style: index == 0
                            ? AppFonts.robotoTextSmallBold
                            : AppFonts.robotoTextSmallRegular,
                      );
                    }),
                  ],
                ),
              ),
              Column(
                children: [
                  Text("Quantity", style: AppFonts.robotoTextSmallMedium),
                  const SizedBox(height: 8),
                  ...mainGenresWatched.map((mainGenre) {
                    return Text(
                      mainGenre.quantity.toString(),
                      style: AppFonts.robotoTextSmallRegular,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
