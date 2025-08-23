// lib/modules/Clients/models/client_model.dart
class Client {
  final String? id;
  final String fullName;
  final String companyName;
  final String email;
  final String phoneNumber;
  final String? gstinTaxId;
  final String? businessType;
  final String streetAddress;
  final String city;
  final String stateProvince;
  final String postalCode;
  final String country;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Client({
    this.id,
    required this.fullName,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    this.gstinTaxId,
    this.businessType,
    required this.streetAddress,
    required this.city,
    required this.stateProvince,
    required this.postalCode,
    required this.country,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      fullName: json['fullName'],
      companyName: json['companyName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gstinTaxId: json['gstinTaxId'],
      businessType: json['businessType'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      stateProvince: json['stateProvince'],
      postalCode: json['postalCode'],
      country: json['country'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gstinTaxId': gstinTaxId,
      'businessType': businessType,
      'streetAddress': streetAddress,
      'city': city,
      'stateProvince': stateProvince,
      'postalCode': postalCode,
      'country': country,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Client copyWith({
    String? id,
    String? fullName,
    String? companyName,
    String? email,
    String? phoneNumber,
    String? gstinTaxId,
    String? businessType,
    String? streetAddress,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Client(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gstinTaxId: gstinTaxId ?? this.gstinTaxId,
      businessType: businessType ?? this.businessType,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      stateProvince: stateProvince ?? this.stateProvince,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
