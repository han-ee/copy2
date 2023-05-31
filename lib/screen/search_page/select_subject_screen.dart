import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String inputRoute;
  final String termid;
  const SelectSubjectScreen(this.termid, this.inputRoute, {super.key});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbSubjectList = [];
  late List<String> displayList = [];
  late String lastRoute;
  bool isLiked = false;
  List favorite = [];

  getUserUid() {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        return (FirebaseAuth.instance.currentUser?.uid)!;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("user not found in");
        return e.code.toString();
      }
    }
  }

  initFavorite() async {
    late String docid;
    String userUid = getUserUid();
    // final query =
    //     await db.collection("학생").where("uuid", isEqualTo: userUid).get();
    // docid = query.docs.first.id;
    final data = await db.collection("학생").doc(userUid).get();
    try {
      if (data['favorite'] != null) {
        setState(() {
          favorite = data['favorite'];
        });
      }
    } catch (e) {
      await db.collection("학생").doc(userUid).update(
        {
          "favorite": [],
        },
      );
    }
  }

  toggleFavorite(String value) async {
    setState(() {
      if (favorite.contains(value)) {
        favorite.remove(value);
      } else {
        favorite.add(value);
      }
    });
    late String docid;
    String userUid = getUserUid();
    final query =
        await db.collection("학생").where("uuid", isEqualTo: userUid).get();
    docid = query.docs.first.id;
    await db.collection("학생").doc(docid).update({
      "favorite": favorite.toSet().toList(),
    });
  }

  collectSubjectList() async {
    print("여기는 과목 선택 페이지");
    lastRoute = "${widget.inputRoute}/${widget.termid}";
    dbSubjectList = [];
    final collRef = db.collection(widget.inputRoute).doc(widget.termid);
    final data = await collRef.get();
    for (var subjectId in data.data()!.keys) {
      dbSubjectList.add(subjectId);
    }
    setState(() {
      displayList = List.from(dbSubjectList.toSet().toList());
      lastRoute = lastRoute;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initFavorite();
    collectSubjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestPage"),
        actions: [
          IconButton(
              onPressed: () {
                print("눌렀음");
                collectSubjectList();
              },
              icon: const Icon(Icons.tab))
        ],
      ),
      body: displayList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final isLiked = favorite.contains(displayList[index]);
                return Container(
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SelectTermScreen(
                      //       displayList[index],
                      //       lastRoute,
                      //     ),
                      //   ),
                      // );
                    },
                    //trailing: const Icon(Icons.hub_outlined),
                    title: Text(
                      displayList[index],
                    ),
                    leading: IconButton(
                      icon: isLiked
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                      onPressed: () {
                        toggleFavorite(displayList[index]);
                      },
                    ),
                    // leading: IconButton(
                    //   icon: isLiked
                    //       ? const Icon(
                    //           Icons.favorite_outlined,
                    //           color: Colors.red,
                    //         )
                    //       : const Icon(
                    //           Icons.favorite_border_outlined,
                    //           color: Colors.red,
                    //         ),
                    //   onPressed: () {
                    //     toggleFavorite(displayList[index]);
                    //   },
                    // ),
                    subtitle: const Text("subtitle"),
                  ),
                );
              },
              itemCount: displayList.length,
            ),
    );
  }
}
