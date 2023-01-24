import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/home/model/book_model.dart';
import 'package:flutter_nusantara/features/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class DetailBook extends StatelessWidget {
  const DetailBook({super.key});

  @override
  Widget build(BuildContext context) {
    final Data data = ModalRoute.of(context)!.settings.arguments as Data;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/editbook', arguments: data.id);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      title: const Text('Delete'),
                      content: const Text('Are you sure to delete this book?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              context
                                  .read<HomeViewModel>()
                                  .deleteBook(context, data.id!);
                            },
                            child: const Text('Ok')),
                      ],
                    )),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subtitle : ${data.subtitle!}'),
            Text('Published : ${data.published!}'),
            Text('Author : ${data.author!}'),
            Text('Publisher : ${data.publisher!}'),
            Text('Website : ${data.website!}'),
            Expanded(child: Text('Description : ${data.description!}')),
          ],
        ),
      ),
    );
  }

  // Future<dynamic> _showAlertDialog(
  //     BuildContext context, String title, String text) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18)),
  //             title: Text(title),
  //             content: Text(text),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     context.read<HomeViewModel>().deleteBook(context, data.id!);
  //                   },
  //                   child: const Text('Ok')),
  //             ],
  //           ));
  // }
}
