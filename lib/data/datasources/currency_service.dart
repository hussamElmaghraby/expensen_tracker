import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiUrl = "https://open.er-api.com/v6/latest/USD";

  Future<double> convertToUSD(String baseCurrency, double amount) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['rates'];
      final rate = rates[baseCurrency];
      if (rate != null && rate != 0) {
        return amount / rate;
      } else {
        throw Exception("Currency not found");
      }
    } else {
      throw Exception("Failed to fetch currency data");
    }
  }
}
