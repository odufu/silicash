class LoginResponse {
  final String token;
  final UserDetails userDetails;
  final int expiresIn;

  const LoginResponse({
    required this.token,
    required this.userDetails,
    required this.expiresIn,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      userDetails: UserDetails.fromJson(json['user_details'] as Map<String, dynamic>),
      expiresIn: json['expires_in'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_details': userDetails.toJson(),
      'expires_in': expiresIn,
    };
  }
}

class UserDetails {
  final String uuid;
  final String email;
  final String phone;
  final Profile profile;
  final String refreshToken;

  const UserDetails({
    required this.uuid,
    required this.email,
    required this.phone,
    required this.profile,
    required this.refreshToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'phone': phone,
      'profile': profile.toJson(),
      'refresh_token': refreshToken,
    };
  }
}

class Profile {
  final String firstName;
  final String fullName;

  const Profile({
    required this.firstName,
    required this.fullName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'] as String,
      fullName: json['full_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'full_name': fullName,
    };
  }
}
