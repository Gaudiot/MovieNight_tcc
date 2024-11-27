part of "../profile.view.dart";

class _ProfileAppBar extends StatelessWidget {
  final VoidCallback onTap;

  const _ProfileAppBar({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        children: [
          UIButton(
            onTap: onTap,
            child: Assets.lib.assets.icBackCircle.svg(),
          ),
        ],
      ),
    );
  }
}

class _BaseHeader extends StatelessWidget {
  final Widget icon;
  final String title;

  const _BaseHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          title,
          style: AppFonts.robotoTextSmallRegular.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}

class _BasePage extends StatelessWidget {
  final Widget icon;
  final String title;

  final Widget child;

  const _BasePage({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BaseHeader(icon: icon, title: title),
        Expanded(
          child: Center(child: child),
        ),
      ],
    );
  }
}

class _TimeSpentWatching extends StatelessWidget {
  final List<DateInfo> watchedTimeInfo;

  const _TimeSpentWatching({
    required this.watchedTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      icon: Assets.lib.assets.oldTelevision.svg(),
      title: AppStrings.profile.timeSpentWatching,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...watchedTimeInfo.map((dateInfo) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateInfo.value.toString(),
                    style: AppFonts.robotoTextSmallBold,
                  ),
                  Text(
                    dateInfo.label,
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TotalMoviesWatched extends StatelessWidget {
  final int totalMoviesWatched;

  const _TotalMoviesWatched({
    required this.totalMoviesWatched,
  });

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      icon: Assets.lib.assets.icPopcorn.svg(),
      title: AppStrings.profile.totalMoviesWatched,
      child: Center(
        child: Text(
          totalMoviesWatched.toString(),
          style: AppFonts.robotoTitleBigBold.copyWith(
            color: AppColors.yellow,
          ),
        ),
      ),
    );
  }
}

class _FavoriteGenre extends StatelessWidget {
  final MovieGenre? genre;

  const _FavoriteGenre({
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      icon: Assets.lib.assets.icStarOutline.svg(),
      title: AppStrings.profile.favoriteGenre,
      child: Center(
        child: Text(
          genre != null ? genre!.label : "",
          style: AppFonts.robotoTitleBigBold.copyWith(
            color: AppColors.yellow,
          ),
        ),
      ),
    );
  }
}
