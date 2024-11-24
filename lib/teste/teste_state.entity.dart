class BaseStateEntity {
  bool isLoading;

  BaseStateEntity({
    this.isLoading = false,
  });

  void setLoading(bool value) {
    isLoading = value;
  }
}

class TesteStateEntity extends BaseStateEntity {
  final int counter;

  TesteStateEntity({
    super.isLoading,
    this.counter = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TesteStateEntity && other.counter == counter;
  }

  TesteStateEntity copyWith({
    int? counter,
  }) {
    return TesteStateEntity(
      counter: counter ?? this.counter,
    );
  }

  @override
  int get hashCode => counter.hashCode;

  TesteStateEntity add() {
    setLoading(true);
    return copyWith(counter: counter + 1);
  }
}
