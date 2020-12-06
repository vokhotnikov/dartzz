// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_instances.dart';

// **************************************************************************
// SyntaxEnrichmentGenerator
// **************************************************************************

// Found 2 instances
// Instance type: ReferencedType(OptionInstanceForTesting, [ReferencedType(A, [])])
// Instance type: ReferencedType(OptionFunctorForTesting, [])
// Raw instance supertype: FunctorForTesting<ForOption>
// Typeclass type: ReferencedType(FunctorForTesting, [ReferencedType(ForOption, [])])
// scheduling syntax type substitution ReferencedType(F, []) -> ReferencedType(ForOption, [])
// Method xmap
// params: [Kind<F, A> f, B Function(A) mapper]
// param types: (Kind<F, A>, B Function(A))
// param runtime type: (InterfaceTypeImpl, FunctionTypeImpl)
//   TypeParameterElementImpl A (A)
//   TypeParameterElementImpl B (B)
//   ParameterElementImpl f (Kind<F, A> f)
//   ParameterElementImpl mapper (B Function(A) mapper)

// Subject type: ReferencedType(Option, [ReferencedType(A, [])])
// Syntax type: ReferencedType(FunctorForTestingSyntax, [ReferencedType(ForOption, [])])
// Constructed 1 proxy extensions
// proxy will be generated here
extension Option__FunctorForTesting__Ext<A> on Option<A> {
  static const syntax =
      FunctorForTestingSyntax<ForOption>(OptionFunctorForTesting());

// methods will be here
  Option<B> xmap<B>(Func1<B, A> mapper) => syntax.xmap(this, mapper).fix();
}
