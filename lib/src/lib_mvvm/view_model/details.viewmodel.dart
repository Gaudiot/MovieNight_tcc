import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/api/movie.api.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/states/details_state.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/streamings.entity.dart";

class DetailsViewmodel extends BaseViewModel {
  final _movieNetwork = MovieApi();

  final DetailsStateEntity _state = DetailsStateEntity();

  DetailsStateEntity get detailsState => _state;

  Future<void> getStreamings(String movieId) async {
    setIsLoading(isLoading: true);

    final streamings = await _movieNetwork.getMovieStreamings(
      request: GetMovieStreamingsRequest(id: int.parse(movieId)),
    );

    if (streamings.hasError || !streamings.data!.hasCountry("BR")) {
      setIsLoading(isLoading: false);
      return;
    }

    final brazilStreamings = streamings.data!.getCountry("BR");

    _state.updateWith(
      streamings: StreamingsList(
        flatrate: brazilStreamings.flatrate,
        buy: brazilStreamings.buy,
        rent: brazilStreamings.rent,
      ),
    );

    setIsLoading(isLoading: false);
  }
}
