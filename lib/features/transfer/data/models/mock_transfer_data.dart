import '../../domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';

const List<TransferCard> mockCards = [
  TransferCard(
    id: '1',
    cardNumber: 'VISA **** **** **** 1234',
    balance: 'Available balance : 14,000\$',
  ),
  TransferCard(
    id: '2',
    cardNumber: 'Account 1234 5678 5689',
    balance: 'Available balance : 10,000\$',
  ),
];

final List<Beneficiary> mockBeneficiaries = [
  const Beneficiary(
    id: '2',
    name: 'khaled',
    cardNumber: '0123456789110',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
  ),
  const Beneficiary(
    id: '3',
    name: 'hala',
    cardNumber: '0123456789111',
    avatarUrl: 'https://i.pravatar.cc/150?img=49',
  ),
  const Beneficiary(
    id: '4',
    name: 'yaser',
    cardNumber: '0123456789112',
    avatarUrl: 'https://i.pravatar.cc/150?img=15',
  ),
  const Beneficiary(
    id: '5',
    name: 'Sarah',
    cardNumber: '0123456789113',
    avatarUrl: 'https://i.pravatar.cc/150?img=44',
  ),
];

const List<String> mockBanks = [
  "Fifth Third",
  "Bank of the West",
  "Wells Fargo",
  "JP Morgan Chae",
  "US bank",
  "HSBS bank",
  "Citibank",
  "Ame Express",
];

const List<String> mockBranches = [
  "New York",
  "California",
  "Chicago",
  "Houston",
  "Phoenix",
  "Philadelphia",
];
