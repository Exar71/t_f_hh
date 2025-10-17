import 'package:flutter/material.dart';
import 'package:t_f_h/core/themes/app_theme.dart';
import 'package:t_f_h/features/club/presentation/pages/club_dashboard_page.dart';
import 'package:t_f_h/presentation/widgets/role_selection_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Football Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoleSelectionButton(
                  width: 60,
                  icon: Icons.shield_outlined,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubDashboardPage(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                RoleSelectionButton(
                  width: 210,
                  text: 'Футбольный клуб',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubDashboardPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoleSelectionButton(
                  width: 60,
                  icon: Icons.person_outline,
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                RoleSelectionButton(
                  text: 'Тренер',
                  width: 210,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoleSelectionButton(
                  width: 60,
                  // text: 'Футболист',
                  icon: Icons.sports_soccer_outlined,
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                RoleSelectionButton(
                  width: 210,
                  text: 'Футболист',
                  // icon: Icons.sports_soccer_outlined,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 290,
              child: Text(
                textAlign: TextAlign.center,
                'ВНИМАНИЕ... Выберите свою роль.\nВ дальнейшем роль изменить нельзя!',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
