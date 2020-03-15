import 'package:meta/meta.dart';
import '../common/kind.dart';

abstract class ForListK {}

@immutable
@sealed
class ListK<A> extends Kind<ForListK, A> {
  final List<A> _wrapped;

  const ListK(this._wrapped);

  @nonVirtual
  List<A> toList() {
    return List<A>.of(_wrapped);
  }

  @nonVirtual
  List<A> get private__rawValue => _wrapped;
}

extension ListKFixableExt<A> on Kind<ForListK, A> {
  ListK<A> fix() { return this as ListK<A>; }
}