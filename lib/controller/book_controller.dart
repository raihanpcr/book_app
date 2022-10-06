import 'dart:convert';
import 'package:book_app/models/book_list_respone.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/book_detail_response.dart';

class BookController extends ChangeNotifier {
  BookListResponse? bookList; //class pada book_list_respone
  fecthBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
    

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  BookDetailResponse? detailBook;

  fecthDetailBookApi(isbn) async {
    // print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);
    

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();
      fecthSimilarBookApi(detailBook!.title!);
    }
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  BookListResponse? similarBooks;

  fecthSimilarBookApi(String title) async {
    // print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/search/${title}');
    var response = await http.get(url);
    

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
}
