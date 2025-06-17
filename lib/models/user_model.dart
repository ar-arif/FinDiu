class UserModel {
  final String id;
  final String name;
  final String email;
  final String studentId;
  final String university;
  final String program;
  final String year;
  final String? photoUrl;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.university,
    required this.program,
    required this.year,
    this.photoUrl,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      studentId: map['studentId'] ?? '',
      university: map['university'] ?? '',
      program: map['program'] ?? '',
      year: map['year'] ?? '',
      photoUrl: map['photoUrl'],
      phone: map['phone'],
      address: map['address'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentId': studentId,
      'university': university,
      'program': program,
      'year': year,
      'photoUrl': photoUrl,
      'phone': phone,
      'address': address,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? studentId,
    String? university,
    String? program,
    String? year,
    String? photoUrl,
    String? phone,
    String? address,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      university: university ?? this.university,
      program: program ?? this.program,
      year: year ?? this.year,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}