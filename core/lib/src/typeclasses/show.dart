abstract class Show<A> {
  String show(A a);

  const Show();
}

class ShowFromToString<A> extends Show<A> {
  const ShowFromToString();

  @override
  String show(A a) {
    return a.toString();
  }
}