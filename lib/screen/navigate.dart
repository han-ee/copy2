import 'package:flutter/material.dart';
import 'package:grad_gg/screen/profile_screen.dart';
import 'package:grad_gg/screen/search_page/search_page.dart';
import 'StatusPage.dart';
import 'mainscreen.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';
import 'package:grad_gg/screen/myspace_screen.dart';
import 'package:grad_gg/screen//editprofile_screen.dart';

//void main() => runApp(MyStatus());


class Mynavi extends StatelessWidget {
  const Mynavi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GG',
        theme: ThemeData(primarySwatch: Colors.grey),
    home: ChangeNotifierProvider(
    create: (context) => NavigationIndexProvider(),
    child: NavPage(),
    ),
    );
  }
}

class NavPage extends StatefulWidget {
  @override
  State<NavPage> createState() => _MyStatusPageState();


}



class _MyStatusPageState extends State<NavPage> { //네비바 화면경로 연결
  int selectedIndex=2;
  final List<Widget> pages = [
    ProfileScreen(),
    MyStatusPage(),
    MainScreen(),
    SearchScreen(),
    MySpaceScreen()
  ];


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationIndexProvider>(context);
    return Scaffold(
      body: pages[provider.selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: "프로필",),
          NavigationDestination(icon: Icon(Icons.calculate), label: "학점계산기"),
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.search), label: '검색'),
          NavigationDestination(icon: Icon(Icons.done), label: '졸업요소'),
        ],

        selectedIndex: provider.selectedIndex,
        onDestinationSelected: (index) {
          provider.setIndex(index);
        }
      ),
    );
  }
}




//졸업요소 임시페이지 ***********졸업요소 연결하면 삭제할것.
class MyCheckPage extends StatelessWidget {
  const MyCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.0,
          ),
          TextButton(
            onPressed: () {
              print('졸업 시켜줘');
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '졸업.GG\n',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '경상국립대학교',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '\n\nMY STATUS NOW',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text('\n\n체크 기초 페이지',
            style: TextStyle(
                fontSize: 30
            ),
          ),
          // Add additional widgets as needed
          Spacer(),
        ],
      ),
    );
  }
}
