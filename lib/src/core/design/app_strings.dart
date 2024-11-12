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
}
