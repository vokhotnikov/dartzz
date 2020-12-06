// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_instances.dart';

// **************************************************************************
// SyntaxEnrichmentGenerator
// **************************************************************************

// Found 1 instances
// Instance type: ReferencedType(StringInstanceForTesting, [])
// Raw instance supertype: TypeclassForTesting<String>
// Typeclass type: ReferencedType(TypeclassForTesting, [ReferencedType(String, [])])
// scheduling syntax type substitution ReferencedType(F, []) -> ReferencedType(String, [])
// Method asString
// params: [F f]
// param types: (F)
// param runtime type: (TypeParameterTypeImpl)
//   ParameterElementImpl f (F f)

// Method isEqTo
// params: [F me, F other]
// param types: (F, F)
// param runtime type: (TypeParameterTypeImpl, TypeParameterTypeImpl)
//   ParameterElementImpl me (F me)
//   ParameterElementImpl other (F other)

// Subject type: ReferencedType(String, [])
// Syntax type: ReferencedType(TypeclassForTestingSyntax, [ReferencedType(String, [])])
// Constructed 1 proxy extensions
// proxy will be generated here
extension String__TypeclassForTesting__Ext on String {
  static const syntax =
      TypeclassForTestingSyntax<String>(StringInstanceForTesting());

// methods will be here
  String asString() => syntax.asString(this);
  bool isEqTo(String other) => syntax.isEqTo(this, other);
}
