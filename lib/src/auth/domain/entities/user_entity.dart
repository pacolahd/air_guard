import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePic,
  });

  const UserEntity.empty()
      : this(
          id: '',
          email: '',
          fullName: '',
          profilePic: '',
        );

  final String id;
  final String email;
  final String fullName;
  final String? profilePic;

  @override
  List<Object?> get props => [id, email, fullName, profilePic];

  @override
  String toString() {
    return 'User{id: $id, email: $email, fullName: $fullName , profilePic: $profilePic}';
  }
}
