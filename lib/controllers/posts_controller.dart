import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/models/post.dart';
import 'package:http/http.dart' as http;

class PostsController {

  final postsNotifier = ValueNotifier<List<Post>>([]);
  final loadingNotifier = ValueNotifier<bool>(false);

  void callAPI() async {

    loadingNotifier.value = true;

    var client = http.Client();
    try {
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      var decodedResponse = jsonDecode(response.body) as List;
      postsNotifier.value = decodedResponse.map((e) => Post.fromMap(e)).toList();
    } finally {
      client.close();
      loadingNotifier.value = false;
    }
  }
}