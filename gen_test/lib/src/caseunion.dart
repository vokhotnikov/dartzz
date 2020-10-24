import 'package:dartzz_meta/dartzz_meta.dart';

@caseUnion([_FirstSubtype, _SecondSubtype])
class _UnionForTesting {}

@caseUnionMember(_UnionForTesting)
class _FirstSubtype implements _UnionForTesting {
  const _FirstSubtype(int a, String b);
}

@caseUnionMember(_UnionForTesting)
class _SecondSubtype implements _UnionForTesting {
  const _SecondSubtype(bool c);
}

@caseUnion([_GenericLeft, _GenericRight])
class _GenericUnion<A, B> {}

@caseUnionMember(_GenericUnion)
class _GenericLeft<B> implements _GenericUnion<String, B> {
  _GenericLeft(String message);
}

@caseUnionMember(_GenericUnion)
class _GenericRight<E extends Exception> implements _GenericUnion<E, int> {
  _GenericRight();
}
