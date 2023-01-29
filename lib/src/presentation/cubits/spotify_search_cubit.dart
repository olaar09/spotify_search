import 'dart:convert';

import 'package:emoodie/src/core/utils/iterable_entity_interface.dart';
import 'package:emoodie/src/core/utils/constants.dart' as st;
import 'package:emoodie/src/core/utils/exceptions.dart';
import 'package:emoodie/src/core/utils/logging.dart';
import 'package:emoodie/src/core/utils/rest_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpotifySearchCubit extends Cubit<SpotifySearchState> {
  final IterableEntity _searchType;
  final String? _itemsKey;

  SpotifySearchCubit(
      {required String itemsKey, required IterableEntity searchType})
      : _searchType = searchType,
        _itemsKey = itemsKey,
        super(SpotifySearchState(loading: false));

  void executeSearch({required String q}) async {
    emit(state.copyWith(loading: () => true, error: null));
    try {
      final response =
          await OAuth2Client.get("/search?type=${_searchType.toString()}&q=$q");
      final data = jsonDecode(response.body);
      final getWithItemKey = data[_itemsKey];
      final items = getWithItemKey == null
          ? []
          : _searchType.fromJsonArr(getWithItemKey['items']);
      _loadedState(items);
      return;
    } on OAuthGrantException catch (e) {
      if (kDebugMode) Logging.out(e.message);
      _errorState(st.error0Auth2);
    } catch (e) {
      if (kDebugMode) Logging.out(e.toString());
      _errorState(e.toString());
      return;
    }
  }

  void _loadedState(List items) {
    emit(state.copyWith(
        loading: () => false, items: () => items, error: () => null));
  }

  void _errorState(String error) {
    emit(state.copyWith(loading: () => false, error: () => error));
  }
}

class SpotifySearchState {
  SpotifySearchState({
    this.loading = false,
    this.error,
    this.items,
  });

  bool loading;
  String? error;
  List? items;

  SpotifySearchState copyWith({
    String? Function()? error,
    bool Function()? loading,
    List? Function()? items,
  }) {
    return SpotifySearchState(
      error: error == null ? this.error : error.call(),
      loading: loading == null ? this.loading : loading.call(),
      items: items == null ? this.items : items.call(),
    );
  }

  @override
  String toString() {
    return " $error $loading $items";
  }
}
