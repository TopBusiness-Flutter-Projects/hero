class GeoCodeModel {
  PlusCode plusCode;
  List<Result> results;
  String status;

  GeoCodeModel({
    required this.plusCode,
    required this.results,
    required this.status,
  });

  factory GeoCodeModel.fromJson(Map<String, dynamic> json) => GeoCodeModel(
    plusCode: PlusCode.fromJson(json["plus_code"]),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "plus_code": plusCode.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({
     this.compoundCode,
     this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}

class Result {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  PlusCode plusCode;
  List<String> types;

  Result({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.plusCode,
    required this.types,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
    placeId: json["place_id"],
    plusCode: json["plus_code"]!=null?PlusCode.fromJson(json["plus_code"]):PlusCode(),
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    "formatted_address": formattedAddress,
    "geometry": geometry.toJson(),
    "place_id": placeId,
    "plus_code": plusCode.toJson(),
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
    longName: json["long_name"],
    shortName: json["short_name"],
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class Geometry {
  Bounds bounds;
  Location location;
  String locationType;
  Bounds viewport;

  Geometry({
    required this.bounds,
    required this.location,
    required this.locationType,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    bounds:json["bounds"]!=null? Bounds.fromJson(json["bounds"]):Bounds(),
    location: Location.fromJson(json["location"]),
    locationType: json["location_type"],
    viewport: Bounds.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds.toJson(),
    "location": location.toJson(),
    "location_type": locationType,
    "viewport": viewport.toJson(),
  };
}

class Bounds {
  Location? northeast;
  Location? southwest;

  Bounds({
     this.northeast,
     this.southwest,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast!.toJson(),
    "southwest": southwest!.toJson(),
  };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
