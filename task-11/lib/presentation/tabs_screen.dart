import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'empty_screen.dart';
import 'receipt_screen.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState () => _TabsScreenState();
}

class _TabsScreenState extends  State<TabsScreen>{
  int _currentPage = 3;

  final List<Widget> _pages = const [
    EmptyScreen(),
    EmptyScreen(),
    EmptyScreen(),
    ReceiptScreen(id: 56)
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const Color activeItemColor = Color.fromRGBO(103, 205, 0, 100);

    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/icons/article.svg',
                  colorFilter: _currentPage == 0 ? const ColorFilter.mode(
                      activeItemColor, BlendMode.srcIn) : null,
                  semanticsLabel: 'Каталог'
              ),
              label: 'Каталог'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  colorFilter: _currentPage == 1 ? const ColorFilter.mode(
                      activeItemColor, BlendMode.srcIn) : null,
                  semanticsLabel: 'Поиск'
              ),
              label: 'Поиск'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/icons/local_mall.svg',
                  colorFilter: _currentPage == 2 ? const ColorFilter.mode(
                      activeItemColor, BlendMode.srcIn) : null,
                  semanticsLabel: 'Каталог'
              ),
              label: 'Корзина'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  colorFilter: _currentPage == 3 ? const ColorFilter.mode(
                      activeItemColor, BlendMode.srcIn) : null,
                  semanticsLabel: 'Личное'
              ),
              label: 'Личное'
          )
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.cardColor,
        selectedItemColor: activeItemColor,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}