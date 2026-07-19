import 'package:easy_pay_app/features/message/domain/entities/account_entity.dart';

class GetAccountsUseCase {
  Future<List<AccountEntity>> call() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return const [
      AccountEntity(
          title: "Account 1",
          accountNumber: "1900 8988 1234",
          availableBalance: 20000.0,
          branch: "New York"),
      AccountEntity(
          title: "Account 2",
          accountNumber: "8988 1234",
          availableBalance: 12000.0,
          branch: "New York"),
      AccountEntity(
          title: "Account 3",
          accountNumber: "1900 1234 2222",
          availableBalance: 230000.0,
          branch: "New York"),
    ];
  }
}
