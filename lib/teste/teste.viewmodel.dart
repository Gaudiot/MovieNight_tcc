import "package:flutter/widgets.dart";
import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/teste/teste_state.entity.dart";

class TesteViewmodel extends BaseViewModel {
  final ValueNotifier<TesteStateEntity> state =
      ValueNotifier(TesteStateEntity());

  TesteViewmodel();

  void add() {
    state.value = state.value.add();
    state.value.isLoading = true;
  }
}
