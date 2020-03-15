import '../common/kind.dart';

abstract class ForLinkedList {}

abstract class LinkedList<A> extends Kind<ForLinkedList, A> {
  const LinkedList();
}

extension ExLinkedListFixable<A> on Kind<ForLinkedList, A> {
  LinkedList<A> fix() { return this as LinkedList<A>; }
}

class Nil<A> extends LinkedList<A> {
  const Nil();
}

class Cons<A> extends LinkedList<A> {
  final A el;

  const Cons(this.el);
}