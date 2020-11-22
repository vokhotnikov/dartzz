// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caseclass.dart';

// **************************************************************************
// Generator: CaseClassesGenerator1
// **************************************************************************

@immutable
class SimpleCaseClass {
  final int anInt;
  final String aStr;

  @protected
  Type get zz_proto => _SimpleCaseClass;

  const SimpleCaseClass(
    this.anInt,
    this.aStr,
  );

  @override
  String toString() =>
      "SimpleCaseClass(${anInt.toString()}, ${aStr.toString()})";

  @override
  bool operator ==(Object other) {
    return other is SimpleCaseClass &&
        anInt == other.anInt &&
        aStr == other.aStr;
  }

// TODO: add hashcode
}

@immutable
class GenericCaseClass<A, B> {
  final A a;
  final B theB;
  final int count;

  @protected
  Type get zz_proto => _GenericCaseClass;

  const GenericCaseClass(
    this.a,
    this.theB,
    this.count,
  );

  @override
  String toString() =>
      "GenericCaseClass(${a.toString()}, ${theB.toString()}, ${count.toString()})";

  @override
  bool operator ==(Object other) {
    return other is GenericCaseClass &&
        a == other.a &&
        theB == other.theB &&
        count == other.count;
  }

// TODO: add hashcode
}

@immutable
class GenericCaseWithRestrictions<E extends Exception, A> {
  final E e;
  final A a;

  @protected
  Type get zz_proto => _GenericCaseWithRestrictions;

  const GenericCaseWithRestrictions(
    this.e,
    this.a,
  );

  @override
  String toString() =>
      "GenericCaseWithRestrictions(${e.toString()}, ${a.toString()})";

  @override
  bool operator ==(Object other) {
    return other is GenericCaseWithRestrictions && e == other.e && a == other.a;
  }

// TODO: add hashcode
}

@immutable
class CompoundCaseClass<T> {
  final GenericCaseClass<String, T> gen;
  final Option<SimpleCaseClass> simples;
  final String test;

  @protected
  Type get zz_proto => _CompoundCaseClass;

  const CompoundCaseClass(
    this.gen,
    this.simples,
    this.test,
  );

  @override
  String toString() =>
      "CompoundCaseClass(${gen.toString()}, ${simples.toString()}, ${test.toString()})";

  @override
  bool operator ==(Object other) {
    return other is CompoundCaseClass &&
        gen == other.gen &&
        simples == other.simples &&
        test == other.test;
  }

// TODO: add hashcode
}
