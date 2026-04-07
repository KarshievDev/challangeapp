import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Challenges'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategoryFilter(context),
            const SizedBox(height: 32),
            _buildFeaturedChallenges(context),
            const SizedBox(height: 32),
            _buildAllChallenges(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.fitness_center, 'label': 'Health', 'color': Colors.blue},
      {'icon': Icons.psychology, 'label': 'Mindset', 'color': Colors.purple},
      {'icon': Icons.lightbulb, 'label': 'Skills', 'color': Colors.orange},
      {'icon': Icons.people, 'label': 'Community', 'color': Colors.green},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: (cat['color'] as Color).withAlpha(30), shape: BoxShape.circle),
              child: Icon(cat['icon'], color: cat['color'], size: 24),
            ),
            const SizedBox(height: 8),
            Text(cat['label'], style: Theme.of(context).textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFeaturedChallenges(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800&auto=format&fit=crop'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withAlpha(100), BlendMode.darken),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                  child: Text('30 Days', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(height: 12),
                Text('Spartan Fitness Challenge', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Transform your body and mind.', style: TextStyle(color: Colors.white.withAlpha(200))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllChallenges(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Challenges', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(16),
              tileColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.primary.withAlpha(30), borderRadius: BorderRadius.circular(15)),
                child: Icon(Icons.wb_sunny, color: AppColors.primary),
              ),
              title: Text('Early Bird Elite', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Wake up at 5am for 21 days straight.'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textCaption),
            );
          },
        ),
      ],
    );
  }
}
