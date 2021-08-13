import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api-m.sandbox.paypal.com"; // for sandbox mode
  //String domain = "https://api-m.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  // for sandbox mode
  String clientId =
      'AZHpxuhzLCfe8y2oStBWwwC2PDGJfEYqDkTuh8m9Xr8LK16H0sLIv71EbH5JqNVqFs80SfpWaqviKCjs';
  String secret =
      'EBDYk0MGbrzCD5SrQS7QgDcPlGuWQEXFJgCyMAT48MxlpDa7t85In-MlSXEqyDOhNZeZ1WDUqJFyvLZ3';

  // for production mode
  // String clientId =
  //     'ARhdmjxrdpdnadTKqc1tXm5tzb9x0xpfpWRq5JPcr6BNsDugfB9UcygPIe23D55TV2DR339I_-5j5-R7';
  // String secret =
  //     'EC--YtHoB7YlfXmC7Ik_hdXm6fg15MnkdSCIzafo3sSWvUBBeWO0HDSdw_jBjuI1CdApAig-6ObXStrc';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return {"executeUrl": "", "approvalUrl": ""};
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<dynamic> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Sucessfull..... STatus code is 200");
        // return body["id"];
        return body;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
