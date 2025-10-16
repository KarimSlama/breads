sealed class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchQueryChanged && other.query == query;
  }

  @override
  int get hashCode => query.hashCode;
}
