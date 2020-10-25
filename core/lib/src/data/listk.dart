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

  @override
  bool operator ==(Object other) {
    if (other is ListK<A>) {
      final raw1 = this._wrapped;
      final raw2 = other._wrapped;
      if (raw1.length != raw2.length) {
        return false;
      } else {
        for (var i = 0; i < raw1.length; ++i) {
          if (raw1[i] != raw2[i]) {
            return false;
          }
          return true;
        }
      }
    } else
      return false;
  }

  @override
  String toString() {
    return '[${_wrapped.join(", ")}]';
  }
}

extension ListKFixableExt<A> on Kind<ForListK, A> {
  ListK<A> fix() {
    return this as ListK<A>;
  }
}
