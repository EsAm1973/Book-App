class Book {
  int? id;
  String? authorname;
  String? bookname;
  String? imgUrl;

  // Constructor
  Book(dynamic obj) {
    id = obj['id'];
    bookname = obj['bookname'];
    authorname = obj['authorname'];
    imgUrl = obj['imgurl'];
  }

  // Named Constructor
  Book.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    bookname = map['bookname'];
    authorname = map['authorname'];
    imgUrl = map['imgurl'];
  }

  // Convert Book object to Map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'bookname': bookname,
      'authorname': authorname,
      'imgurl': imgUrl,
    };
    return map;
  }

  // Getters
  get showBookId => id;
  get showAuthorName => authorname;
  get showBookName => bookname;
  get showImgUrl => imgUrl;
}
