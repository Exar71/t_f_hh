import 'package:flutter/material.dart';
import 'dart:async';

import 'package:t_f_h/features/club/presentation/club_finances_page.dart';
import 'package:t_f_h/features/club/presentation/club_squad_page.dart';
import 'package:t_f_h/features/club/presentation/club_staff_page.dart';
import 'package:t_f_h/features/club/presentation/club_tactics_page.dart';
import 'package:t_f_h/features/club/presentation/club_training_page.dart';
import 'package:t_f_h/features/club/presentation/club_transfers_page.dart';

class ClubDashboardPage extends StatefulWidget {
  const ClubDashboardPage({super.key});

  @override
  State<ClubDashboardPage> createState() => _ClubDashboardPageState();
}

class _ClubDashboardPageState extends State<ClubDashboardPage> {
  late Future<List<_DashboardItem>> _dashboardItems;

  @override
  void initState() {
    super.initState();
    _dashboardItems = _loadDashboardItems();
  }

  Future<List<_DashboardItem>> _loadDashboardItems() async {
    // Simulate a network call or data loading
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      _DashboardItem(
        title: 'Squad',
        icon: Icons.groups_outlined,
        color: Colors.blue,
        page: ClubSquadPage(),
      ),
      _DashboardItem(
        title: 'Tactics',
        icon: Icons.lightbulb_outline,
        color: Colors.orange,
        page: ClubTacticsPage(),
      ),
      _DashboardItem(
        title: 'Training',
        icon: Icons.fitness_center_outlined,
        color: Colors.green,
        page: ClubTrainingPage(),
      ),
      _DashboardItem(
        title: 'Transfers',
        icon: Icons.sync_alt_outlined,
        color: Colors.red,
        page: ClubTransfersPage(),
      ),
      _DashboardItem(
        title: 'Staff',
        icon: Icons.person_outline,
        color: Colors.purple,
        page: ClubStaffPage(),
      ),
      _DashboardItem(
        title: 'Finances',
        icon: Icons.monetization_on_outlined,
        color: Colors.teal,
        page: ClubFinancesPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Dashboard')),
      body: FutureBuilder<List<_DashboardItem>>(
        future: _dashboardItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildGridView(snapshot.data!);
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildGridView(List<_DashboardItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _AnimatedGridItem(item: items[index], index: index);
      },
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  const _DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });
}

class _AnimatedGridItem extends StatefulWidget {
  final _DashboardItem item;
  final int index;

  const _AnimatedGridItem({required this.item, required this.index});

  @override
  __AnimatedGridItemState createState() => __AnimatedGridItemState();
}

class __AnimatedGridItemState extends State<_AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1 * widget.index, 1.0, curve: Curves.easeOut),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: _DashboardCard(item: widget.item),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final _DashboardItem item;

  const _DashboardCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.page),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 48, color: item.color),
            const SizedBox(height: 12),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
