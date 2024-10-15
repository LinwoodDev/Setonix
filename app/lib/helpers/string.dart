extension StringHelper on String {
  bool equalsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());
}
