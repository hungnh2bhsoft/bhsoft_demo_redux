import 'search_result.dart';

class SearchAction {
  final String query;

  const SearchAction(this.query);
}

class SearchInitialAction {}

class SearchLoadingAction {}

class SearchEmptyAction {}

class SearchSuccessAction {
  final SearchResult searchResult;

  const SearchSuccessAction(this.searchResult);
}

class SearchFailureAction {}
