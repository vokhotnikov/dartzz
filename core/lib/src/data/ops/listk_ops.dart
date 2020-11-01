import '../option.dart';
import '../listk.dart';
import '../../syntax/option_syntax.dart';

extension ListKOps<A> on ListK<A> {
  int get length => this.private__rawValue.length;

  Option<A> headOption() => Some<List<A>>(this.private__rawValue)
      .filter((l) => l.isNotEmpty)
      .map((l) => l[0]);

  Option<ListK<A>> tailOption() => Some<List<A>>(this.private__rawValue)
      .filter((l) => l.isNotEmpty)
      .map((l) => ListK<A>(l.getRange(1, l.length)));

  ListK<A> add(A newEl) {
    var rawCopy = List<A>.from(this.private__rawValue);
    rawCopy.add(newEl);
    return ListK<A>(rawCopy);
  }

  Option<A> atOption(int index) {
    if (index < 0 || index >= this.length) {
      return None();
    } else {
      return Some(this.private__rawValue[index]);
    }
  }

  ListK<A> concat(ListK<A> newValues) {
    // TODO: this should probably be replaced or unified with Monoid<ListK>
    var rawCopy = List<A>.from(this.private__rawValue);
    rawCopy.addAll(newValues.private__rawValue);
    return ListK<A>(rawCopy);
  }
}
