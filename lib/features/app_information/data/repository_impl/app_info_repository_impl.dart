import 'package:easy_pay_app/features/app_information/data/data_source/app_info_remote_data_source.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';
import 'package:easy_pay_app/features/app_information/domain/repository_interface/app_info_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoRemoteDataSource remoteDataSource;

  AppInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AppInfoEntity> getAppInfo() async {
    final model = await remoteDataSource.getAppInfo();
    return AppInfoEntity(
      appName: model.appName ,
      version: model.version ,
      dateOfManufacture: model.dateOfManufacture ,
      language: model.language
    );
  }
}
