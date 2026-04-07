import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/localization.dart';
import '../../blocs/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.explore),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=User&background=007AFF&color=fff'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeSection(context, l10n),
            const SizedBox(height: 32),
            _buildActiveChallengesSection(context, l10n),
            const SizedBox(height: 32),
            _buildSocialFeedSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, AppLocalization l10n) {
    final state = context.read<AuthBloc>().state;
    final name = (state is AuthAuthenticated) ? (state.user.displayName ?? 'Recruit') : 'Recruit';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.welcome, style: Theme.of(context).textTheme.bodySmall),
        Text(name, style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(50), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.streakLabel, style: TextStyle(color: Colors.white.withAlpha(200))),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
                        const SizedBox(width: 4),
                        Text('12 Days', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: Colors.white.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                child: Text('Level 4', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveChallengesSection(BuildContext context, AppLocalization l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.activeChallenges, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Simple horizontally scrolling list of active challenges
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 260,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.textCaption.withAlpha(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: AppColors.primary.withAlpha(30), borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.fitness_center, size: 20, color: AppColors.primary),
                        ),
                        const Spacer(),
                        Text('${l10n.day} 8/21', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Morning Running', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.4,
                        minHeight: 8,
                        backgroundColor: AppColors.textCaption.withAlpha(20),
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSocialFeedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Friend Filter', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey.withAlpha(50), child: Icon(Icons.person, color: Colors.blue)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'John Doe ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            TextSpan(text: 'completed ', style: TextStyle(color: AppColors.textCaption)),
                            TextSpan(text: '21 Days of Reading', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Text('2 hours ago', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(Icons.favorite_border, color: AppColors.textCaption, size: 18),
              ],
            );
          },
        ),
      ],
    );
  }
}
