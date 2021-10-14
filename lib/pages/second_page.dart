import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/models/post.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({ Key? key }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

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
        title: const Text("Segunda página"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonWidget(
              title: "Call API",
              onPressed: () {
                callAPI();
              },
              titleSize: 18,
            ),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: loadingNotifier,
                builder: (_,isLoading,__) {

                  if(isLoading) {
                    return const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()
                    );
                  }

                  return ValueListenableBuilder<List<Post>>(
                    valueListenable: postsNotifier, 
                    builder: (_,value,__) { // O segundo argumento tá tipado como int pq meu valueNotifier é do tipo int
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (_,index) {
                          return ListTile(
                            title: Text(value[index].title),
                          );
                        }
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