part of 'paging_bloc.dart';

abstract class PagingEvent<T> extends Equatable {
  const PagingEvent();

  @override
  List<Object> get props => [];
}

class LoadMorePagingEvent<T> extends PagingEvent<T> {
  const LoadMorePagingEvent(this.list);

  final List<T> list;

  @override
  List<Object> get props => [list];
}

class ReplacePagingEvent<T> extends PagingEvent<T> {
  const ReplacePagingEvent(this.list);

  final List<T> list;

  @override
  List<Object> get props => [list];
}

class InsertOrReplacePagingEvent<T> extends PagingEvent<T> {
  const InsertOrReplacePagingEvent(this.item);

  final T item;

  @override
  List<Object> get props => [item];
}

class InsertOrMovePagingEvent<T> extends PagingEvent<T> {
  const InsertOrMovePagingEvent(this.item);

  final T item;

  @override
  List<Object> get props => [item];
}