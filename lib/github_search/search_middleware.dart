import 'dart:async';

import 'package:async/async.dart';
import 'package:redux/redux.dart';
import 'github_search_service.dart';
import 'search_actions.dart';
import 'search_state.dart';

class SearchMiddleware extends MiddlewareClass<SearchState> {
  final GithubSearch _githubSearch;

  SearchMiddleware({GithubSearch? githubSearch})
      : _githubSearch = githubSearch ?? GithubSearch();

  Timer? _timer;
  CancelableOperation<Store<SearchState>>? _operation;

  @override
  call(Store<SearchState> store, action, NextDispatcher next) {
    _timer = Timer(const Duration(milliseconds: 250), () {
      if (action is SearchAction) {
        _timer?.cancel();
        _operation?.cancel();
        if (action.query.isEmpty) {
          store.dispatch(SearchInitialAction());
        } else {
          store.dispatch(SearchLoadingAction());

          _operation = CancelableOperation.fromFuture(
            _githubSearch.searchRepositories(action.query).then((result) {
              if (result.totalCount! == 0) {
                return store..dispatch(SearchEmptyAction());
              } else {
                return store..dispatch(SearchSuccessAction(result));
              }
            }).catchError(
              (Object e, StackTrace s) => store
                ..dispatch(
                  SearchFailureAction(),
                ),
            ),
          );
        }
      }
    });
    next(action);
  }
}
