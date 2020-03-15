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
}
