import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/enums/app_routes.enum.dart";
import "package:movie_night_tcc/src/base/widgets/base_wrapper.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_feature/home/search_movies/search_movies.view.dart";
import "package:movie_night_tcc/src/lib_feature/home/watched/watched.view.dart";
import "package:movie_night_tcc/src/lib_feature/home/watchlist/watchlist.view.dart";
import "package:movie_night_tcc/src/shared/components/ui_button.dart";

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final navigation = locator.get<INavigation>();
  int currentIndex = 0;

  Widget pageBuilder(int index) {
    return switch (index) {
      0 => SearchMoviesView(),
      1 => WatchlistView(),
      2 => WatchedView(),
      _ => const SizedBox.shrink(),
    };
  }

  void onTap([int index = 0]) {
    if (index == currentIndex) return;
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      appBar: _HomeAppBar(
        onPrefixTap: onTap,
        onSuffixTap: () => navigation.push(path: AppRoutes.profile),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          pageBuilder(currentIndex),
          BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: AppColors.black.withOpacity(0.8),
            selectedFontSize: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                activeIcon: Assets.lib.assets.movieRoll.svg(),
                icon: Assets.lib.assets.movieRollOutline.svg(),
                label: "Home",
              ),
              BottomNavigationBarItem(
                activeIcon: Assets.lib.assets.bookmark.svg(),
                icon: Assets.lib.assets.bookmarkOutline.svg(),
                label: "Search",
              ),
              BottomNavigationBarItem(
                activeIcon: Assets.lib.assets.camera.svg(),
                icon: Assets.lib.assets.cameraOutline.svg(),
                label: "Profile",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  final VoidCallback? onPrefixTap;
  final VoidCallback? onSuffixTap;

  const _HomeAppBar({
    this.onPrefixTap,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        children: [
          UIButton(
            inkwellOpacity: 0,
            onTap: onPrefixTap,
            child: Assets.lib.assets.movieNightLogo.svg(),
          ),
          const Spacer(),
          UIButton(
            inkwellOpacity: 0,
            onTap: onSuffixTap,
            child: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
