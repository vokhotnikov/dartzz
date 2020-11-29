// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_instances.dart';

// **************************************************************************
// SyntaxEnrichmentGenerator
// **************************************************************************

// Found 1 instances
// Instance type: ReferencedType(OptionInstanceForTesting, [ReferencedType(A, [])])
// Typeclass type: ReferencedType(TypeclassForTesting, [ReferencedType(Kind, [ReferencedType(ForOption, []), ReferencedType(A, [])])])
// Subject type: ReferencedType(Kind, [ReferencedType(ForOption, []), ReferencedType(A, [])])
// Syntax type: ReferencedType(TypeclassForTestingSyntax, [ReferencedType(F, [])])
// Constructed 1 proxy extensions
// proxy will be generated here
extension Kind__TypeclassForTesting__Ext on Kind {
  static const syntax =
      TypeclassForTestingSyntax<Kind>(OptionInstanceForTesting<A>());

// methods will be here
  String asString() => syntax.asString(this);
  bool isEqTo(Kind other) => syntax.isEqTo(this, other);
}
