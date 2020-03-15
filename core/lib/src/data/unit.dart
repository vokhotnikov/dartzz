class Unit {
  static final Unit _singleInstance = Unit._internal();

  const Unit._internal();

  factory Unit() {
    return _singleInstance;
  }
}