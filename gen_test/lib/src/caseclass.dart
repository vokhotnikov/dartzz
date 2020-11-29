import 'package:meta/meta.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:dartzz_meta/dartzz_meta.dart';

part 'caseclass.g.dart';

@caseclass
class _SimpleCaseClass {
  const _SimpleCaseClass(int anInt, String aStr);
}

@caseclass
class _GenericCaseClass<A, B> {
  const _GenericCaseClass(A a, B theB, int count);
}

@caseclass
class _GenericCaseWithRestrictions<E extends Exception, A> {
  const _GenericCaseWithRestrictions(E e, A a);
}

@caseclass
class _CompoundCaseClass<T> {
  const _CompoundCaseClass(_GenericCaseClass<String, T> gen,
      Option<_SimpleCaseClass> simples, String test);
}
