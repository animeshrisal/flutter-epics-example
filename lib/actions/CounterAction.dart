class IncreaseCounter {
  int _id = 0;

  IncreaseCounter() {
    _id++;
  }

  int get id => _id;
}

class DecreaseCounter {
  int _id = 0;
  DecreaseCounter() {
    _id--;
  }

  int get id => _id;
}
