// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:emoodie/src/utils/exceptions.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart';

Future<oauth2.Client> _getOauthGrant() async {
  try {
    // ignore: todo
    // TODO: Save credentials in encrypted storage
    // config storage such as firebase storage
    const identifier = '3af8e17840684c5bb3325a5e8b8e808d';
    const secret = 'e46b037b7f76416ca7e3ac9676f557f7';

    final tokenEndpoint = Uri.parse('https://accounts.spotify.com/api/token');

    return await oauth2
        .clientCredentialsGrant(tokenEndpoint, identifier, secret, scopes: [
      'playlist-read-private',
      'playlist-read-collaborative',
      'playlist-modify-public',
      'user-read-private'
    ]);
  } catch (e) {
    throw OAuthGrantException(message: e.toString());
  }
}

class OAuth2Client {
  static const String _baseUrl = "https://api.spotify.com/v1";

  static Future<Response> post(String path,
      {Map<String, dynamic>? data}) async {
    final request = await _getOauthGrant();
    return request.post(Uri.parse("$_baseUrl$path"), body: data);
  }

  static Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    final request = await _getOauthGrant();
    return request.put(Uri.parse("$_baseUrl$path"), body: data);
  }

  static Future<Response> get(String path) async {
    final request = await _getOauthGrant();
    return await request.get(Uri.parse("$_baseUrl$path"));
  }

  static Future<Response> delete(String path) async {
    final request = await _getOauthGrant();
    return await request.delete(Uri.parse("$_baseUrl$path"));
  }
}
