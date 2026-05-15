extension StringHelper on String {
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();

  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());
}
