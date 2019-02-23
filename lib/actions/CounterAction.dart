class IncreaseCounter {
  static int _id;

  IncreaseCounter() {
    _id++;
  }

  int get id => _id;
}

class DecreaseCounter {
  static int _id ;
  DecreaseCounter() {
    _id--;
  }

  int get id => _id;
}
