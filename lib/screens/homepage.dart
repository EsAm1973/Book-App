import 'package:flutter/material.dart';
import 'package:task1_sqlite/Database.dart/helper.dart';
import 'package:task1_sqlite/Widgets/add_book_sheet.dart';
import 'package:task1_sqlite/Widgets/book_item.dart';
import 'package:task1_sqlite/models/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  Db_Helper? db;

  @override
  void initState() {
    super.initState();
    db = Db_Helper();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    var dbHelper = Db_Helper();
    List<Map<String, dynamic>> books = await dbHelper.getBooks();
    setState(() {
      _books = books.map((book) => Book.fromMap(book)).toList();
    });
  }

  void _removeBook(int bookId) async {
    await db!.deleteBook(bookId);
    _fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                    context: context, builder: (context) => AddBookBottomSheet())
                .then((_) => _fetchBooks());
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade900,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Available Books',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: _books.isEmpty
            ? const Center(
                child: Text('No Books Available'),
              )
            : ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  return BookListItem(
                    book: _books[index],
                    onDelete: () => _removeBook(_books[index].showBookId),
                  );
                },
              ),
      ),
    );
  }
}
