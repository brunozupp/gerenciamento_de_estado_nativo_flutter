import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/models/post.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class ThirdPage extends StatefulWidget {
  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terceira página"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonWidget(
              title: "Call API página 3",
              onPressed: () {
                callAPI();
              },
              titleSize: 18,
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: Listenable.merge([postsNotifier,loadingNotifier]), // Muda sempre que um desses muda
                builder: (_,__) {

                  if(loadingNotifier.value) {
                    return const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()
                    );
                  }

                  return ListView.builder(
                    itemCount: postsNotifier.value.length,
                    itemBuilder: (_,index) {
                      return ListTile(
                        title: Text(postsNotifier.value[index].title),
                      );
                    }
                  );
                }
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}