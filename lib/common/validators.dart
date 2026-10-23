String? validateGroupName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Group name required';
  }
  if (value.length > 30) {
    return 'Group name too long';
  }
  return null;
}
