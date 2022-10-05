import 'package:flutter/material.dart';

/*
https://picsum.photos/300/200?random=1
https://picsum.photos/300/200?random=2
https://picsum.photos/300/200?random=3
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Viewer")),
        body: Main(),
      ),
    );
  }
}

class Main extends StatelessWidget {
  final myController = TextEditingController();
  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Insert some Urls"),
        TextField(
          controller: myController,
          decoration:
              const InputDecoration(contentPadding: EdgeInsets.all(20.0)),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        ImageDialogWrapper(
            () => myController.text.split("\n")), //but at launch empty string!
      ],
    );
  }
}

class ImageDialogWrapper extends StatelessWidget {
  final Function getUrls;
  const ImageDialogWrapper(this.getUrls, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
          //Built-in function in flutter that creates a modal
          context: context,
          builder: (context) => ImageDialog(getUrls())),
      child: const Text("Show!"),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final List<String> urls;
  const ImageDialog(this.urls, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Image> images = urls.map((url) => Image.network(url)).toList();
    return ListView(
      children: [
        ...images, //images[0], images[1], ...
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("ok")),
      ],
    );
  }
}
