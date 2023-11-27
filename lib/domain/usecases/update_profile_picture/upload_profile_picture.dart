import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/update_profile_picture/upload_profile_picture_body.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureBody> {
  final UserRepository userRepository;

  UploadProfilePicture({
    required this.userRepository,
  });

  @override
  Future<Result<User>> call(UploadProfilePictureBody params) =>
      userRepository.uploadProfilePicture(
        user: params.user,
        pictureFile: params.pictureFile,
      );
}
