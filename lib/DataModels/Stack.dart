class Stack {
  final String label;
  final String value;

  Stack({
    required this.label,
    required this.value,
  });

  factory Stack.fromJson(Map<String, dynamic> json) {
    return Stack(
      label: json['label'],
      value: json['value'],
    );
  }
}