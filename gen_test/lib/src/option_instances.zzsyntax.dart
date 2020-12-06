// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_instances.dart';

// **************************************************************************
// SyntaxEnrichmentGenerator
// **************************************************************************

// Found 2 instances
// Instance type: ReferencedType(OptionInstanceForTesting, [ReferencedType(A, [])])
// Raw instance supertype: TypeclassForTesting<Option<A>>
// Instance type: ReferencedType(OptionFilteringFunctorForTesting, [])
// Raw instance supertype: FilteringFunctorForTesting<ForOption>
// Typeclass type: ReferencedType(FilteringFunctorForTesting, [ReferencedType(ForOption, [])])
// scheduling syntax type substitution ReferencedType(F, []) -> ReferencedType(ForOption, [])
// Method xfmap
// params: [Kind<F, A> f, bool Function(A) predicate, B Function(A) mapper]
// param types: (Kind<F, A>, bool Function(A), B Function(A))
// param runtime type: (InterfaceTypeImpl, FunctionTypeImpl, FunctionTypeImpl)
//   TypeParameterElementImpl A (A)
//   TypeParameterElementImpl B (B)
//   ParameterElementImpl f (Kind<F, A> f)
//   ParameterElementImpl predicate (bool Function(A) predicate)
//   ParameterElementImpl mapper (B Function(A) mapper)

// Subject type: ReferencedType(Option, [ReferencedType(A, [])])
// Syntax type: ReferencedType(FilteringFunctorForTestingSyntax, [ReferencedType(ForOption, [])])
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
// Constructed 2 proxy extensions
// proxy will be generated here
extension Option__FilteringFunctorForTesting__Ext<A> on Option<A> {
  static const syntax = FilteringFunctorForTestingSyntax<ForOption>(
      OptionFilteringFunctorForTesting());

// methods will be here
  Option<B> xfmap<B>(Func1<bool, A> predicate, Func1<B, A> mapper) =>
      syntax.xfmap(this, predicate, mapper).fix();
}

// proxy will be generated here
extension Option__FunctorForTesting__Ext<A> on Option<A> {
  static const syntax =
      FunctorForTestingSyntax<ForOption>(OptionFilteringFunctorForTesting());

// methods will be here
  Option<B> xmap<B>(Func1<B, A> mapper) => syntax.xmap(this, mapper).fix();
}
