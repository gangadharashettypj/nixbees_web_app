/*
 * @Author GS
 */

import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue(0)
  student,
  @JsonValue(1)
  teacher,
  @JsonValue(2)
  guest,
}

extension UserTypeExtension on UserType {
  int get rawValue {
    switch (this) {
      case UserType.student:
        return 0;
      case UserType.teacher:
        return 1;
      case UserType.guest:
        return 2;
      default:
        return 0;
    }
  }

  String get stringValue {
    switch (this) {
      case UserType.student:
        return 'Student';
      case UserType.teacher:
        return 'Teacher';
      case UserType.guest:
        return 'Guest';
      default:
        return 'Student';
    }
  }

  String get image {
    switch (this) {
      case UserType.student:
        return 'https://www.pngkit.com/png/full/176-1761189_help-your-student-college-student-icon-png.png';
      case UserType.teacher:
        return 'https://i.pinimg.com/originals/19/46/9a/19469aed7f222d6009f48158a682bb9c.png';
      case UserType.guest:
        return '';
      default:
        return 'https://image.flaticon.com/icons/png/512/201/201818.png';
    }
  }

  static UserType init(int val) {
    switch (val) {
      case 0:
        return UserType.student;
      case 1:
        return UserType.teacher;
      case 2:
        return UserType.guest;
      default:
        return UserType.student;
    }
  }
}
