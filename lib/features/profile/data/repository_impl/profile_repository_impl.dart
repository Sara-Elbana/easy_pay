import 'package:easy_pay_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:easy_pay_app/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_pay_app/features/profile/domain/repository_interface/profile_repository_interface.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity> getProfile() async {
    final model = await remoteDataSource.getProfileData();
    return ProfileEntity(
      name: model.user.name,
      phone: model.user.phone,
      accountNumber: model.account.accountNumber,
      balance: model.account.balance,
      cardNumber: model.card.cardNumber,
      cardHolderName: model.card.cardHolderName,
      cardType: model.card.cardType,
      expirationDate: model.card.expirationDate,
    );
  }
}
