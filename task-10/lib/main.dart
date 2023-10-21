import 'package:flutter/material.dart';

abstract class TestAppColors {
  static const secondary = Color(0xff292929);
  static const about = Colors.blue;
  static const hobby = Colors.red;
  static const skill = Colors.blue;
  static const text = Colors.white;
  static const secondaryText = Colors.grey;
  static const background = Color(0xff222222);
  static const avatarBorder = Colors.white24;
  static final shadow = Colors.black.withOpacity(0.1);
}

abstract class TestAppStrings {
  static const appBar = 'Моя страница';
  static const sectionAboutLbl = 'О себе';
  static const sectionHobbyLbl = 'Увлечения';
  static const sectionSkillLbl = 'Опыт в разработке';
  static const sectionAboutText = 'Человек ищущий вселенское счастье в этой жизни';
  static const sectionHobbyText = 'Eternal Sunshine of the Spotless Mind';
  static const sectionSkillText = '''- back end C#, ASP.NET, (WebForms, MVC 5, .net 6)
- front end knockoutjs, Angular, Vue 3
- mobile Ionic 6 (Vue 3), Flutter
- разработка и верстка дизайна с помощью HTML, CSS (Bootstrap)
- работа с MS SQL: T-SQL и проектирование структуры БД''';
}

abstract class TestAppMocks {
  static const name = 'Пронин Андрей';
  static const avatarPath = 'assets/h47VcJt5JSQ.jpg';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          TestAppStrings.appBar,
          style: TextStyle(color: TestAppColors.text),
        ),
        backgroundColor: TestAppColors.background,
      ),
      backgroundColor: TestAppColors.background,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: MainPersonalDataSection(
                imgPath: TestAppMocks.avatarPath,
                name: TestAppMocks.name,
               ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: MainCategoriesPanel(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ));
  }
}

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final bool showIcon;
  final String imgPath;

  const CustomCircleAvatar({
    required this.radius,
    required this.showIcon,
    required this.imgPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: radius * 2,
      child: Stack(
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: TestAppColors.avatarBorder,
                width: 2.5,
              ),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPersonalDataSection extends StatelessWidget {
  final String name;
  final String imgPath;

  const MainPersonalDataSection({
    required this.name,
    required this.imgPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(
          radius: 60,
          showIcon: true,
          imgPath: imgPath,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  color: TestAppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MainCategoriesPanel extends StatelessWidget {
  const MainCategoriesPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomCard(
                title: TestAppStrings.sectionAboutLbl,
                description: TestAppStrings.sectionAboutText,
                icon: Icons.people,
                iconColor: TestAppColors.about,
                background: TestAppColors.secondary,
                textStyle: TextStyle(
                    color: TestAppColors.secondaryText,
                    fontFamily: 'Roboto',
                    fontSize: 24,
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomCard(
                title: TestAppStrings.sectionHobbyLbl,
                description: TestAppStrings.sectionHobbyText,
                iconColor: TestAppColors.hobby,
                icon: Icons.sports,
                background: TestAppColors.secondary,
                  textStyle: TextStyle(
                    color: TestAppColors.secondaryText,
                    fontFamily: 'Jura',
                    fontSize: 24,
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomCard(
                title: TestAppStrings.sectionSkillLbl,
                description: TestAppStrings.sectionSkillText,
                iconColor: TestAppColors.skill,
                icon: Icons.science,
                background: TestAppColors.secondary,
                textStyle: TextStyle(
                  color: TestAppColors.secondaryText,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final Color? background;
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final TextStyle textStyle;

  const CustomCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.textStyle,
    this.background,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: TestAppColors.secondaryText,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  description,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: textStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  const Header(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: TestAppColors.text,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}