class RentModel {
  int? id;
  final String imageUrl;
  final String cityName;
  final String detailAddress;
  final String rentPrice;
  final bool isFavorite;
  final String rentId;
  final int noofBeds;

  RentModel({
    this.id,
    required this.imageUrl,
    required this.cityName,
    required this.detailAddress,
    required this.rentPrice,
    this.isFavorite = false,
    required this.rentId,
    required this.noofBeds,
  });

  RentModel copyWith({
    int? id,
    String? imageUrl,
    String? cityName,
    String? detailAddress,
    String? rentId,
    String? rentPrice,
    bool? isFavorite,
    int? noofBeds,
  }) {
    return RentModel(
      rentId: rentId ?? this.rentId,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      cityName: cityName ?? this.cityName,
      detailAddress: detailAddress ?? this.detailAddress,
      rentPrice: rentPrice ?? this.rentPrice,
      isFavorite: isFavorite ?? this.isFavorite,
      noofBeds: noofBeds ?? this.noofBeds,
    );
  }

  // Convert object to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'cityName': cityName,
      'detailAddress': detailAddress,
      'rentPrice': rentPrice,
      'isFavorite': isFavorite ? 1 : 0,
      'rentId': rentId,
      'noofBeds': noofBeds,
    };
  }

  factory RentModel.fromMap(Map<String, dynamic> map) {
    return RentModel(
      id: map['id'],
      rentId: map['rentId'],
      imageUrl: map['imageUrl'],
      cityName: map['cityName'],
      detailAddress: map['detailAddress'],
      rentPrice: map['rentPrice'],
      isFavorite: map['isFavorite'] == 1,
      noofBeds: map['noofBeds'],
    );
  }
}
