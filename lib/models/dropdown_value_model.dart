class DropdownValue {
  final String value;
  final String title;

  DropdownValue({required this.value, required this.title});

  // Convert the DropdownValue object to a map (must be serializable)
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'title': title,
    };
  }

  // Convert a map to a DropdownValue object
  static DropdownValue fromMap(Map<String, dynamic> map) {
    return DropdownValue(
      value: map['value'] ?? '',
      title: map['title'] ?? '',
    );
  }
}