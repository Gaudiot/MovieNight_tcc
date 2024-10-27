enum StorageCollections {
  watched(collectionName: "watched"),
  watchlist(collectionName: "watchlist");

  final String collectionName;

  const StorageCollections({required this.collectionName});
}
