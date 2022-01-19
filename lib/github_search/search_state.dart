import 'search_result.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchEmptyState extends SearchState {}

class SearchSuccessState extends SearchState {
  final SearchResult result;

  SearchSuccessState(this.result);
}

class SearchFailureState extends SearchState {}
