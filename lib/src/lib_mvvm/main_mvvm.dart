import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/search_movies.view.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/watched.view.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/watchlist.view.dart";
import "package:movie_night_tcc/src/shared/widgets/ui_button.dart";

class MainMvvmDefault extends StatefulWidget {
  const MainMvvmDefault({super.key});

  @override
  State<MainMvvmDefault> createState() => _MainMvvmDefaultState();
}

class _MainMvvmDefaultState extends State<MainMvvmDefault> {
  int currentIndex = 0;

  final List<Widget> pages = [
    SearchMoviesView(),
    WatchlistView(),
    WatchedView(),
  ];

  Widget pageBuilder(int index) {
    return switch (index) {
      0 => SearchMoviesView(),
      1 => WatchlistView(),
      2 => WatchedView(),
      _ => const SizedBox.shrink(),
    };
  }

  void onTap([int index = 0]) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 12, bottom: 16),
          color: AppColors.darkestBlue,
          child: Row(
            children: [
              UIButton(
                onTap: onTap,
                child: Assets.lib.assets.movieNightLogo.svg(),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.darkestBlue,
      body: Stack(
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
