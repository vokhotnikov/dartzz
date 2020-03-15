import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';

part 'caseclass.g.dart';


@caseClass()
class _SimpleCaseClass {
  const _SimpleCaseClass(int anInt, String aStr);
}

@caseClass()
class _GenericCaseClass<A, B> {
  const _GenericCaseClass(A a, B theB, int count);
}

@caseClass()
class _GenericCaseWithRestrictions<E extends Exception, A> {
  const _GenericCaseWithRestrictions(E e, A a);
}

@caseClass()
class _CompoundCaseClass<T> {
  const _CompoundCaseClass(_GenericCaseClass<String, T> gen, _SimpleCaseClass simple, String test);
}
