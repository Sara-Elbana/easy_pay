import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/data/data_source/app_info_remote_data_source.dart';
import 'package:easy_pay_app/features/app_information/data/model/app_info_model.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';
import 'package:easy_pay_app/features/app_information/domain/repository_interface/app_info_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoRemoteDataSource remoteDataSource;

  AppInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<AppInfoEntity>> getAppInfo() async {
    final result = await remoteDataSource.getAppInfo();

    if (result is ApiSuccess<AppInfoModel>) {
      final model = result.data;
      final entity = AppInfoEntity(
        appName: model.appName,
        version: model.version,
        dateOfManufacture: model.dateOfManufacture,
        language: model.language,
      );
      return ApiSuccess(data: entity, message: result.message);
    }

    final failure = result as ApiFailure<AppInfoModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}
