import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'search_actions.dart';
import 'search_middleware.dart';
import 'search_reducer.dart';
import 'search_state.dart';

class GithubSearch extends StatelessWidget {
  GithubSearch({
    Key? key,
  }) : super(key: key);

  final GithubSearch githubSearch = GithubSearch();

  Store<SearchState> searchStore = Store<SearchState>(
    searchReducer,
    initialState: SearchInitialState(),
    middleware: [SearchMiddleware()],
  );

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        SearchInput(searchTextController: searchTextController),
        Expanded(child: ResultView()),
      ]),
    );
  }
}

class ResultView extends StatelessWidget {
  const ResultView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, SearchState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _buildResultScreen(state),
        );
      },
    );
  }

  Widget _buildResultScreen(SearchState state) {
    if (state is SearchLoadingState) {
      return Center(child: Text('Searching...'));
    }
    if (state is SearchEmptyState) {
      return Center(child: Text('No results'));
    }
    if (state is SearchFailureState) {
      return Center(child: Text('Error'));
    }
    if (state is SearchSuccessState) {
      final items = (state as SearchSuccessState).result.items!;
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          return ListTile(
            leading: CircleAvatar(
              foregroundImage: NetworkImage(item.owner!.avatarUrl as String),
            ),
            title: Text(item.name as String),
            subtitle: Text(item.description ?? "None"),
          );
        },
      );
    }
    return Center(
      child: const Text("Search for repositories"),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required this.searchTextController,
  }) : super(key: key);

  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<SearchState>(
      builder: (_, store) => TextField(
        controller: searchTextController,
        decoration: InputDecoration(
          hintText: "Search...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              store.dispatch(SearchAction(searchTextController.text));
            },
          ),
        ),
      ),
    );
  }
}
