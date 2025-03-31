import 'package:hive/hive.dart';

part 'vault_card.g.dart';

@HiveType(typeId: 0)
class VaultCard extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String account;

  @HiveField(2)
  final String? password;

  @HiveField(3)
  final bool isMultiCard;

  @HiveField(4)
  final List<VaultCard> subCards;

  VaultCard({
    required this.id,
    required this.account,
    this.password,
    required this.isMultiCard,
    List<VaultCard>? subCards,
  }) : subCards = subCards ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'account': account,
        'password': password,
        'isMultiCard': isMultiCard,
        'subCards': subCards.map((card) => card.toJson()).toList(),
      };

  factory VaultCard.fromJson(Map<String, dynamic> json) => VaultCard(
        id: json['id'],
        account: json['account'],
        password: json['password'],
        isMultiCard: json['isMultiCard'],
        subCards: (json['subCards'] as List)
            .map((item) => VaultCard.fromJson(item))
            .toList(),
      );
}
