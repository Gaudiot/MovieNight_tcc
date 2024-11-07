enum AppLanguageEnum {
  ptBr,
  enUs,
}

AppLanguageEnum appLanguage = AppLanguageEnum.enUs;

class AppStrings {
  static String addToWatchlist = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Planejar",
    AppLanguageEnum.enUs => "Add Watchlist",
  };

  static String addToWatched = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Assistido",
    AppLanguageEnum.enUs => "Add Watched",
  };

  static String trending = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Em alta",
    AppLanguageEnum.enUs => "Trending",
  };

  static String watchlist = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Planejados",
    AppLanguageEnum.enUs => "Watchlist",
  };

  static String search = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Pesquisa",
    AppLanguageEnum.enUs => "Search",
  };

  static String profile = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Perfil",
    AppLanguageEnum.enUs => "Profile",
  };

  static String watched = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Assistido",
    AppLanguageEnum.enUs => "Watched",
  };

  static String searchMovies = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Pesquisar filmes...",
    AppLanguageEnum.enUs => "Search movies...",
  };

  static String favorites = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Favoritos",
    AppLanguageEnum.enUs => "Favorites",
  };

  static String emptyList = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Você não tem nenhum filme. Assista um hoje!",
    AppLanguageEnum.enUs =>
      "You don't have any movies. Try watching one today!",
  };

  static String genericError = switch (appLanguage) {
    AppLanguageEnum.ptBr =>
      "Algo inesperado aconteceu. Tente novamente mais tarde.",
    AppLanguageEnum.enUs => "Something unexpected happened. Try again later.",
  };

  static String noMoviesFound = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Desculpe, não encontramos nenhum filme.",
    AppLanguageEnum.enUs => "Sorry, we couldn't find any movies.",
  };

  static String loadingMovies = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Carregando filmes...",
    AppLanguageEnum.enUs => "Loading movies...",
  };

  static String timeSpentWatching = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Tempo assistido",
    AppLanguageEnum.enUs => "Time spent watching",
  };

  static String totalMoviesWatched = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Filmes assistidos",
    AppLanguageEnum.enUs => "Movies watched",
  };

  static String favoriteGenre = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Gênero favorito",
    AppLanguageEnum.enUs => "Favorite genre",
  };

  static String mainGenresWatched = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Principais gêneros assistidos",
    AppLanguageEnum.enUs => "Main genres watched",
  };

  static String deleteMyData = switch (appLanguage) {
    AppLanguageEnum.ptBr => "Apagar meus dados",
    AppLanguageEnum.enUs => "Delete my data",
  };

  static String years(int value) => switch (appLanguage) {
        AppLanguageEnum.ptBr => value == 1 ? "ano" : "anos",
        AppLanguageEnum.enUs => value == 1 ? "year" : "years",
      };

  static String months(int value) => switch (appLanguage) {
        AppLanguageEnum.ptBr => value == 1 ? "mês" : "meses",
        AppLanguageEnum.enUs => value == 1 ? "month" : "months",
      };

  static String days(int value) => switch (appLanguage) {
        AppLanguageEnum.ptBr => value == 1 ? "dia" : "dias",
        AppLanguageEnum.enUs => value == 1 ? "day" : "days",
      };

  static String hours(int value) => switch (appLanguage) {
        AppLanguageEnum.ptBr => value == 1 ? "hora" : "horas",
        AppLanguageEnum.enUs => value == 1 ? "hour" : "hours",
      };

  static String minutes(int value) => switch (appLanguage) {
        AppLanguageEnum.ptBr => value == 1 ? "minuto" : "minutos",
        AppLanguageEnum.enUs => value == 1 ? "minute" : "minutes",
      };
}
