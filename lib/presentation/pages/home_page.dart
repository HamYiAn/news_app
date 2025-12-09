import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/presentation/widgets/bottom_navigation.dart';
import 'package:news_app/presentation/widgets/corrective_machine_card.dart';
import 'package:news_app/presentation/widgets/spare_part_usage_card.dart';
import 'package:news_app/presentation/widgets/trouble_by_area_card.dart';
import 'package:news_app/presentation/pages/profile_page.dart';
import 'package:news_app/presentation/pages/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeContent(), NewsPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CorrectiveMachineCard(),
                const SizedBox(height: 20),
                const TroubleByAreaCard(),
                const SizedBox(height: 20),
                const SparePartUsageCard(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
