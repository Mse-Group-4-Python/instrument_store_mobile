extension DoubleExt on double {
  String toPrice() {
    return '${toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    )} \$';
  }
}
