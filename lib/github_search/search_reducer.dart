import 'search_actions.dart';
import 'search_result.dart';
import 'search_state.dart';

SearchState searchReducer(SearchState state, action) {
  if (action is SearchLoadingAction) {
    return SearchLoadingState();
  }

  if (action is SearchSuccessAction) {
    for (var item in action.searchResult.items!) {
      print(item);
    }
    return SearchSuccessState(action.searchResult);
  }

  if (action is SearchEmptyAction) {
    return SearchEmptyState();
  }

  if (action is SearchFailureAction) {
    return SearchFailureState();
  }

  return SearchInitialState();
}
