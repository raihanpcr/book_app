import 'dart:convert';
import 'package:book_app/models/book_list_respone.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookListResponse? bookList; //class pada book_list_respone
  fecthBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      setState(() {});
    }

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  void initState() {
    super.initState();
    fecthBookApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalogue"),
      ),
      body: Container(
          child: bookList == null ? 
          Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookList!.books![index];
                    return Row(
                      children: [
                        Image.network(
                          currentBook.image!,
                          height: 100,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentBook.title!),
                                Text(currentBook.subtitle!),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(currentBook.price!),
                                    ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  })),
    );
  }
}