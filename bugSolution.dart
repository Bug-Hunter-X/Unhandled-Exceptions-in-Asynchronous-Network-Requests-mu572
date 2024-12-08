```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomNetworkException implements Exception {
  final String message;
  CustomNetworkException(this.message);
  @override
  String toString() => message;
}

Future<Map<String, dynamic>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw CustomNetworkException('Data not found (404)');
    } else {
      throw CustomNetworkException('Request failed with status: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    throw CustomNetworkException('Network error: $e');
  } catch (e) {
    throw CustomNetworkException('An unexpected error occurred: $e');
  }
}

void main() async {
  try {
    final data = await fetchData();
    print('Data: $data');
  } catch (e) {
    print('Error: $e');
  }
}
```