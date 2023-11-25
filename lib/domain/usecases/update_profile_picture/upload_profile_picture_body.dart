import 'dart:io';
import 'package:flix_tix/domain/entities/user.dart';

class UploadProfilePictureBody {
  final User user;
  final File pictureFile;

  UploadProfilePictureBody({
    required this.user,
    required this.pictureFile,
  });
}
