class Streaming {
  final String providerId;
  final String providerName;
  final String logoPath;

  const Streaming({
    required this.providerId,
    required this.providerName,
    required this.logoPath,
  });

  String get imageUrl => "https://image.tmdb.org/t/p/original$logoPath";

  factory Streaming.fromJson(Map<String, dynamic> json) => Streaming(
        providerId: json["provider_id"].toString(),
        providerName: json["provider_name"] as String,
        logoPath: json["logo_path"] as String,
      );

  Map<String, dynamic> toJson() => {
        "provider_id": providerId,
        "provider_name": providerName,
        "logo_path": logoPath,
      };
}

class StreamingsList {
  final List<Streaming> flatrate;
  final List<Streaming> buy;
  final List<Streaming> rent;

  const StreamingsList({
    required this.flatrate,
    required this.buy,
    required this.rent,
  });

  bool get isNotEmpty =>
      flatrate.isNotEmpty || buy.isNotEmpty || rent.isNotEmpty;

  const StreamingsList.empty()
      : flatrate = const [],
        buy = const [],
        rent = const [];

  factory StreamingsList.fromJson(Map<String, dynamic> json) {
    final flatrateJson = json["flatrate"] as List<dynamic>?;
    final buyJson = json["buy"] as List<dynamic>?;
    final rentJson = json["rent"] as List<dynamic>?;

    return StreamingsList(
      flatrate: flatrateJson?.map((e) => Streaming.fromJson(e)).toList() ?? [],
      buy: buyJson?.map((e) => Streaming.fromJson(e)).toList() ?? [],
      rent: rentJson?.map((e) => Streaming.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "flatrate": flatrate.map((e) => e.toJson()).toList(),
        "buy": buy.map((e) => e.toJson()).toList(),
        "rent": rent.map((e) => e.toJson()).toList(),
      };
}
