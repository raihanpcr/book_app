
import 'package:book_app/controller/book_controller.dart';

import 'package:book_app/views/detail_book_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fecthBookApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        builder: (context, controller, child) => Container(
            child: bookController!.bookList == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: bookController!.bookList!.books!.length,
                    itemBuilder: (context, index) {
                      final currentBook =
                          bookController!.bookList!.books![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailBookPage(
                                isbn: currentBook.isbn13!,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
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
                        ),
                      );
                    })),
      ),
    );
  }
}
