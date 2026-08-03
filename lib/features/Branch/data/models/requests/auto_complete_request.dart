class AutoCompleteRequest {
  final String query;

  const AutoCompleteRequest({
    required this.query,
  });

  Map<String, dynamic> toJson() {
    return {
      'query': query,
    };
  }
}
