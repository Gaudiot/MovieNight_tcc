import "package:flutter/foundation.dart";

class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<void> setIsLoading({required bool isLoading}) async {
    if (this.isLoading == isLoading) return;
    this.isLoading = isLoading;
    await Future.delayed(Duration.zero, notifyListeners);
  }
}
