import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser(
      {required this.uid,
      required this.email,
      this.profilePic,
      this.bio,
      required this.points,
      required this.fullName,
      this.groupIds = const [],
      this.enrolledCourseIds = const [],
      this.following = const [],
      this.followers = const []});

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
          profilePic: '',
          bio: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          followers: const [],
          following: const [],
        );

  @override
  List<Object?> get props => [
    uid, 
    email,
    profilePic,
    bio,
    points,
    fullName,
    groupIds.length,
    enrolledCourseIds.length,
    following.length,
    followers.length
    ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid,email: $email, bio: $bio, points: $points, fullName: $fullName}';
  }

// Map<String, dynamic> toMap(){
//   return{
//     'uid': this.uid,
//     'email': this.email,
//     'profilePic': this.profilePic,
//     'bio': this.bio,
//     'points':this.points,
//     'fullName':this.fullName,
//     'groupIds':this.groupIds,
//     'enrolledCourseIds':this.enrolledCourseIds,
//     'following':this.following,
//     'followers':this.followers,
//   };
// }

// factory LocalUser.fromMap(Map<String,dynamic> map){
//   return LocalUser(
//     uid: map['uid'] as String,
//     email: map['email'] as String,
//     profilePic: map['profilePic'] as String,
//     bio: map['bio'] as String,
//     points: map['points'] as int,
//     fullName: map['fullName'] as String,
//     groupIds: map['groupIds'] as List<String>,
//     enrolledCourseIds: map['enrolledCourseIds'] as List<String>,
//     following: map['following'] as List<String>,
//     followers: map['followers'] as List<String>,

//   );

  // LocalUser copyWith({
  //   String? uid,
  //   String? email,
  //   String? profilePic,
  //   String? bio,
  //   int? points,
  //   String? fullName,
  //   List<String>? groupIds,
  //   List<String>? enrolledCourseIds,
  //   List<String>? following,
  //   List<String>? followers,
  // }) {
  //   return LocalUser(
  //     uid: uid ?? this.uid,
  //     email: email ?? this.email,
  //     profilePic: profilePic ?? this.profilePic,
  //     bio: bio ?? this.bio,
  //     points: points ?? this.points,
  //     fullName: fullName ?? this.fullName,
  //     groupIds: groupIds ?? this.groupIds,
  //     enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
  //     following: following ?? this.following,
  //     followers: followers ?? this.followers,
  //   );
  // }
}
