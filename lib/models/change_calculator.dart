class ChangeCalculator {
  static const List<int> noteDenominations = [500, 100, 50, 20, 10, 5, 2, 1];

  static Map<int, int> calculateChange(int amount) {
    Map<int, int> change = {};
    int remaining = amount;

    for (int denom in noteDenominations) {
      if (remaining >= denom) {
        int count = remaining ~/ denom;
        change[denom] = count;
        remaining -= count * denom;
      }
    }

    return change;
  }
}