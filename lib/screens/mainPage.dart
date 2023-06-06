import 'package:flutter/material.dart';
import 'package:sumday/screens/bookmark.dart';
import 'package:sumday/screens/diaries.dart';
import 'package:sumday/screens/newDiary.dart';
import 'package:sumday/screens/settings.dart';
import 'package:sumday/screens/home.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget> [Home(), Diaries(), NewDiary(), Bookmark(),Settings()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight * 0.15; // 화면 높이의 10%

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/small_logo.png'),
          onPressed: (){
            print('home_icon is clicked');
          },
        ),
        actions: [
          IconButton(
            onPressed:(){
              print('search Icon');
            },
            icon: Icon(Icons.search, color: Colors.black38,),
          ),
          IconButton(
            onPressed:(){
              print('alarm Icon');
            },
            icon: Icon(Icons.alarm, color: Colors.black38,),
          ),
          IconButton(
            onPressed:(){
              print('edit Icon');
            },
            icon: Icon(Icons.edit, color: Colors.black38,),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: '목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size:45 ,),
            label:'',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: '북마크',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xffF4C54F),
        onTap: _onItemTapped,
      ),
    );
  }
}
