import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/update_profile_picture/update_profile_picture_body.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class UpdateProfilePicture implements UseCase<void, UpdateProfilePictureBody> {
  final UserRepository userRepository;

  UpdateProfilePicture({
    required this.userRepository,
  });

  @override
  Future<Result<void>> call(UpdateProfilePictureBody params) =>
      userRepository.uploadProfilePicture(
        user: params.user,
        pictureFile: params.pictureFile,
      );
}
