import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Leaderboard'),
      ),
      body: Column(
        children: [
          _buildPodium(context),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildPodium(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRanker(context, 'Jane', '2', '8,400 XP', 90, Color(0xFFAFAFAF)), // Silver
          const SizedBox(width: 16),
          _buildRanker(context, 'John Master', '1', '12,500 XP', 110, Color(0xFFFFD700)), // Gold
          const SizedBox(width: 16),
          _buildRanker(context, 'Alex', '3', '7,200 XP', 90, Color(0xFFCD7F32)), // Bronze
        ],
      ),
    );
  }

  Widget _buildRanker(BuildContext context, String name, String rank, String xp, double size, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CircleAvatar(
              radius: size / 2,
              backgroundColor: color,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: (size - 4) / 2,
                  backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=$name&background=007AFF&color=fff'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
              child: Text(rank, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Text(xp, style: TextStyle(color: AppColors.textCaption, fontSize: 12)),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final rank = index + 4;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.textCaption.withAlpha(10)),
          ),
          child: Row(
            children: [
              Text('#$rank', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textCaption)),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=User$rank&background=007AFF&color=fff'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text('User Name $rank', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text('${1000 - rank * 50} XP', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        );
      },
    );
  }
}
