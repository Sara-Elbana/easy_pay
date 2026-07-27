import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/account_model.dart';

class AccountRemoteDataSource {
  final ApiService apiService;

  AccountRemoteDataSource(this.apiService);

  Future<List<AccountModel>> getAccounts() async {
    final response = await apiService.get(ApiConstants.accountsEndpoint);
    final data = response.data;
    List accountsList = data is Map ? data['accounts'] ?? [] : data;
    return accountsList.map((json) => AccountModel.fromJson(json)).toList();
  }
}
