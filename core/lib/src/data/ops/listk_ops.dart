import '../option.dart';
import '../listk.dart';
import '../func.dart';
import '../tuples.dart';
import '../range.dart';
import '../../syntax/option_syntax.dart';
import '../../syntax/listk_syntax.dart';
import 'dart:math';

extension ListKOps<A> on ListK<A> {
  int get length => this.private__rawValue.length;

  bool get isEmpty => this.length == 0;

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

  ListK<A> prepend(A newEl) {
    var rawCopy = List<A>.from(this.private__rawValue);
    rawCopy.insert(0, newEl);
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

  ListK<A> sortBy<B extends Comparable>(Func1<B, A> selector) {
    final copy = List<A>.of(this.private__rawValue);
    copy.sort((x, y) => Comparable.compare(selector(x), selector(y)));
    return ListK<A>(copy);
  }

  ListK<Tuple2<A, B>> zipWith<B>(ListK<B> other) {
    // TODO: possibly might implement via fold: https://stackoverflow.com/questions/28131135/how-to-implement-zip-with-foldl-in-an-eager-language
    var res = <Tuple2<A, B>>[];

    final rawAs = this.private__rawValue;
    final rawBs = other.private__rawValue;
    final newLength = min(rawAs.length, rawBs.length);
    for (var i = 0; i < newLength; ++i) {
      res.add(Tuple2<A, B>(rawAs[i], rawBs[i]));
    }

    return ListK<Tuple2<A, B>>(res);
  }

  ListK<Tuple2<int, A>> zipWithIndex() {
    final indexes = IntRange(0, this.length).toList();
    return indexes.zipWith(this);
  }
}
