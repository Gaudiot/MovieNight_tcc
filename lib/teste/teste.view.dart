import "package:flutter/material.dart";
import "package:movie_night_tcc/teste/teste.viewmodel.dart";
import "package:movie_night_tcc/teste/teste_state.entity.dart";

class TesteView extends StatelessWidget {
  const TesteView({super.key});

  @override
  Widget build(BuildContext context) {
    return TesteViewBody();
  }
}

class TesteViewBody extends StatelessWidget {
  final TesteViewmodel viewmodel = TesteViewmodel();

  TesteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<TesteStateEntity>(
        valueListenable: viewmodel.state,
        builder: (context, state, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.counter.toString()),
                ElevatedButton(
                  onPressed: viewmodel.add,
                  child: const Text("Incrementar"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
