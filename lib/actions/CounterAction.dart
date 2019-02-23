class IncreaseCounter {
  static int _id = 0;

  IncreaseCounter() {
    _id++;
  }

  int get id => _id;
}

class DecreaseCounter {
  static int _id = 0;
  DecreaseCounter() {
    _id--;
  }

  int get id => _id;
}
