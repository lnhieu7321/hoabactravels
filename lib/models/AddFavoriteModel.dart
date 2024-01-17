class FavoriteService {
  final int services_id;
  final int users_id;


  FavoriteService({
    required this.services_id,
    required this.users_id,
  });

  factory FavoriteService.fromJson(Map<String, dynamic> json) {
    return FavoriteService(
      services_id: int.parse(json['services_id']),
      users_id: int.parse(json['users_id']),

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "services_id": services_id,
      "users_id": users_id,
    };
  }
}