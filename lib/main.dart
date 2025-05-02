import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // change to toggle between yellow (light mode) and red (dark mode)
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Profile',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.yellow.shade100,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.yellow),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red.shade900,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
      ),
      home: Builder(
        builder: (BuildContext context) {
          return LoginPage(
            onLogin: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder:
                      (context) => ProfilePage(
                        onToggleTheme: toggleTheme,
                        currentThemeMode: _themeMode,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode currentThemeMode;

  const ProfilePage({
    Key? key,
    required this.onToggleTheme,
    required this.currentThemeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String themeText =
        currentThemeMode == ThemeMode.light
            ? 'Light Theme (Yellow)'
            : 'Dark Theme (Red)';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      // background color follows theme scaffoldBackgroundColor
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Selamat Anda Berhasil Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Change Theme'),
              subtitle: Text('Current: $themeText'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: onToggleTheme,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder:
                        (context) => LoginPage(
                          onLogin: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder:
                                    (context) => ProfilePage(
                                      onToggleTheme: onToggleTheme,
                                      currentThemeMode: currentThemeMode,
                                    ),
                              ),
                            );
                          },
                        ),
                  ),
                );
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
