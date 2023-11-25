import 'dart:io';
import 'package:flix_tix/domain/entities/user.dart';

class UpdateProfilePictureBody {
  final User user;
  final File pictureFile;

  UpdateProfilePictureBody({
    required this.user,
    required this.pictureFile,
  });
}
