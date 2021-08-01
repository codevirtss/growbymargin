import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/bookdetail.dart';

class OfferBookDetails extends StatefulWidget {
  final bookId;
  const OfferBookDetails({Key? key, required this.bookId}) : super(key: key);

  @override
  _OfferBookDetailsState createState() => _OfferBookDetailsState();
}

var boodDatabyId;
Future getBookDetailById(String bookId) async {
  await FirebaseFirestore.instance
      .collection("BookCollection")
      .doc(bookId)
      .get()
      .then((value) {
    boodDatabyId = value.data();
  });
}

class _OfferBookDetailsState extends State<OfferBookDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBookDetailById(widget.bookId),
        builder: (cnotext, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DetailBook(
              bookID: widget.bookId,
              imgUrl: boodDatabyId["bookCoverImageUrl"],
              bdesc: boodDatabyId["bookDescription"],
              bMrp: boodDatabyId["bookMrp"],
              bname: boodDatabyId["bookName"],
              price: boodDatabyId["bookPrice"],
              prev: boodDatabyId["bookPreviewUrl"],
              collName: boodDatabyId["bookCollectionName"],
              author: "Raza Khan",
            );
          } else {
            return new Text("error");
          }
        });
  }
}
