// Aquesta classe és la que interactúa amb l'API per obtenir la informació
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VideosApi {
  // Aquesta és la URL base, que es proporcionarà en el moment de la instanciació.
  String baseURL = "http://localhost:8080/api/videolist";

  // Constructor
  VideosApi(this.baseURL);

  // Obté una llista de JSON amb el resultat de l'API
  Future<List<dynamic>> getVideos() async {
    String url = baseURL;

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;

      return bodyJSON;
    } else {
      return [];
    }
  }

}
