import '../common/kind.dart';

abstract class ForListK {}

class ListK<A> extends Kind<ForListK, A> {
  final List<A> _wrapped;

  ListK(List<A> wrapped): _wrapped = List.unmodifiable(wrapped);

  List<A> toList() {
    return _wrapped;
  }
}

extension ListKFixableExt<A> on Kind<ForListK, A> {
  ListK<A> fix() { return this as ListK<A>; }
}