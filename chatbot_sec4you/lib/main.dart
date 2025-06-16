import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'firebase_messaging_service.dart';
import 'chat_screen.dart';
import 'leak_check_screen.dart';
import 'local_data.dart';
import 'boards_screen.dart';
import 'board_screen.dart';
import 'user_location_service.dart';
import 'users_map_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await LocalData().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService.initialize();
  await UserLocationService.saveUserLocation(); // Salva localização ao abrir o app
  runApp(const Sec4YouApp());
}

class Sec4YouApp extends StatelessWidget {
  const Sec4YouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sec4You',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          iconTheme: IconThemeData(color: Color(0xFFFAF9F6)),
          titleTextStyle: TextStyle(
            color: Color(0xFFFAF9F6),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'JetBrainsMono',
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1A1A),
          selectedItemColor: Color(0xFF7F2AB1),
          unselectedItemColor: Color(0xFFFAF9F6),
          type: BottomNavigationBarType.fixed,
        ),
        fontFamily: 'JetBrainsMono',
      ),
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  String _autoMessage = '';

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _autoMessage = '';
    });
  }

  void _changeTab(int index, String autoMsg) {
    setState(() {
      _selectedIndex = index;
      _autoMessage = autoMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(),
      ChatScreen(initialMessage: _autoMessage),
      LeakCheckerScreen(changeTab: _changeTab),
      BoardsScreen(),
      UsersMapScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Vazamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Fórum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
        ],
      ),
    );
  }
}