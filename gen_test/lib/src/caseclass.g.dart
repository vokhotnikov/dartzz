// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caseclass.dart';

// **************************************************************************
// CaseClassesGenerator
// **************************************************************************

@immutable
class SimpleCaseClass {
  final int anInt;
  final String aStr;

  @protected
  Type get zz__proto => _SimpleCaseClass;

  const SimpleCaseClass(this.anInt, this.aStr);

  @override
  String toString() {
    return "SimpleCaseClass(${anInt.toString()}, ${aStr.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is SimpleCaseClass &&
        anInt == other.anInt &&
        aStr == other.aStr;
  }
}

// metadata:
//
//  ConstructorElementImpl
//   ParameterElementImpl anInt
//   ParameterElementImpl aStr

@immutable
class GenericCaseClass<A, B> {
  final A a;
  final B theB;
  final int count;

  @protected
  Type get zz__proto => _GenericCaseClass;

  const GenericCaseClass(this.a, this.theB, this.count);

  @override
  String toString() {
    return "GenericCaseClass(${a.toString()}, ${theB.toString()}, ${count.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is GenericCaseClass &&
        a == other.a &&
        theB == other.theB &&
        count == other.count;
  }
}

// metadata:
//
//  ConstructorElementImpl
//   ParameterElementImpl a
//   ParameterElementImpl theB
//   ParameterElementImpl count
//  TypeParameterElementImpl A
//  TypeParameterElementImpl B

@immutable
class GenericCaseWithRestrictions<E extends Exception, A> {
  final E e;
  final A a;

  @protected
  Type get zz__proto => _GenericCaseWithRestrictions;

  const GenericCaseWithRestrictions(this.e, this.a);

  @override
  String toString() {
    return "GenericCaseWithRestrictions(${e.toString()}, ${a.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is GenericCaseWithRestrictions && e == other.e && a == other.a;
  }
}

// metadata:
//
//  ConstructorElementImpl
//   ParameterElementImpl e
//   ParameterElementImpl a
//  TypeParameterElementImpl E
//  TypeParameterElementImpl A

@immutable
class CompoundCaseClass<T> {
  final GenericCaseClass gen;
  final SimpleCaseClass simple;
  final String test;

  @protected
  Type get zz__proto => _CompoundCaseClass;

  const CompoundCaseClass(this.gen, this.simple, this.test);

  @override
  String toString() {
    return "CompoundCaseClass(${gen.toString()}, ${simple.toString()}, ${test.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is CompoundCaseClass &&
        gen == other.gen &&
        simple == other.simple &&
        test == other.test;
  }
}

// metadata:
// - @caseClass caseClass()
//  - @caseClass caseClass()
//  ConstructorElementImpl
//   ParameterElementImpl gen
//   ParameterElementImpl simple
//   ParameterElementImpl test
//  TypeParameterElementImpl T
