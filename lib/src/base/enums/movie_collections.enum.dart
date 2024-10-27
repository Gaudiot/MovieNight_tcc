enum MovieCollections {
  watched(collectionName: "watched"),
  watchlist(collectionName: "watchlist");

  final String collectionName;

  const MovieCollections({required this.collectionName});
}
