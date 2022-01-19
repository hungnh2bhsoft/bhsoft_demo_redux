class SearchResult {
  final int? totalCount;
  final bool? incompleteResults;
  final List<Items>? items;

  SearchResult({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  SearchResult.fromJson(Map<String, dynamic> json)
      : totalCount = json['total_count'] as int?,
        incompleteResults = json['incomplete_results'] as bool?,
        items = (json['items'] as List?)
            ?.map((dynamic e) => Items.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'incomplete_results': incompleteResults,
        'items': items?.map((e) => e.toJson()).toList()
      };
}

class Items {
  final int? id;
  final String? name;
  final Owner? owner;
  final String? description;

  Items({
    this.id,
    this.name,
    this.owner,
    this.description,
  });

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        owner = (json['owner'] as Map<String, dynamic>?) != null
            ? Owner.fromJson(json['owner'] as Map<String, dynamic>)
            : null,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'owner': owner?.toJson(),
        'description': description
      };
}

class Owner {
  final String? login;
  final String? avatarUrl;

  Owner({
    this.login,
    this.avatarUrl,
  });

  Owner.fromJson(Map<String, dynamic> json)
      : login = json['login'] as String?,
        avatarUrl = json['avatar_url'] as String?;

  Map<String, dynamic> toJson() => {'login': login, 'avatar_url': avatarUrl};
}
