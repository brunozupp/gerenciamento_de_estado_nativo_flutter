import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/controllers/posts_controller.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/models/post.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/widgets/custom_button_widget.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  final _controller = PostsController();

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
                _controller.callAPI();
              },
              titleSize: 18,
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller.postsNotifier,_controller.loadingNotifier]), // Muda sempre que um desses muda
                builder: (_,__) {

                  if(_controller.loadingNotifier.value) {
                    return const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()
                    );
                  }

                  return ListView.builder(
                    itemCount: _controller.postsNotifier.value.length,
                    itemBuilder: (_,index) {
                      return ListTile(
                        title: Text(_controller.postsNotifier.value[index].title),
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