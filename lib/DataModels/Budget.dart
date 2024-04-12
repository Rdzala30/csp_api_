class Budget {
  final String type;
  final String typeValue;

  Budget({
    required this.type,
    required this.typeValue,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      type: json['type'],
      typeValue: json['type_value'],
    );
  }
}