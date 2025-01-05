import "package:movie_night_tcc/src/lib_feature/details/streamings.entity.dart";

class DetailsStateEntity {
  StreamingsList streamings;

  DetailsStateEntity({
    this.streamings = const StreamingsList.empty(),
  });

  void updateWith({
    StreamingsList? streamings,
  }) {
    this.streamings = streamings ?? this.streamings;
  }
}
