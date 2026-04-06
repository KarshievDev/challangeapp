import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/localization.dart';
import '../../blocs/auth_bloc.dart';
import '../../blocs/language_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = (state is AuthAuthenticated) ? state.user : null;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.profile),
            actions: [
              IconButton(icon: Icon(Icons.settings_outlined), onPressed: () => _showSettings(context, l10n)),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, user),
                const SizedBox(height: 32),
                _buildStats(context, user),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Unlockable Badges'),
                const SizedBox(height: 16),
                _buildBadgesGrid(context, user),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Personal Goals'),
                const SizedBox(height: 16),
                _buildGoalsList(context, user),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, user) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user?.photoURL ?? 'https://ui-avatars.com/api/?name=${user?.displayName ?? "User"}&background=007AFF&color=fff'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.primary, border: Border.all(color: Colors.white, width: 2), shape: BoxShape.circle),
              child: Icon(Icons.edit, size: 16, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(user?.displayName ?? 'Recruit', style: Theme.of(context).textTheme.displayMedium),
        Text(user?.email ?? 'Level 1 Warrior', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildStats(BuildContext context, user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(context, 'XP', '${user?.xp ?? 0}', AppColors.primary),
        _buildStatSeparator(),
        _buildStatItem(context, 'Streak', '12', Colors.orange),
        _buildStatSeparator(),
        _buildStatItem(context, 'Rank', '84', Colors.purple),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildStatSeparator() {
    return Container(height: 30, width: 1, color: AppColors.textCaption.withAlpha(20));
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildBadgesGrid(BuildContext context, user) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 16),
      itemCount: 8,
      itemBuilder: (context, index) {
        bool unlocked = index < 3;
        return Opacity(
          opacity: unlocked ? 1 : 0.3,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.cardBackground, border: Border.all(color: unlocked ? AppColors.primary : Colors.transparent), shape: BoxShape.circle),
            child: Icon(Icons.military_tech, size: 24, color: unlocked ? AppColors.secondary : AppColors.textCaption),
          ),
        );
      },
    );
  }

  Widget _buildGoalsList(BuildContext context, user) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppColors.secondary),
              const SizedBox(width: 12),
              Expanded(child: Text('Complete 3 challenges this month', style: TextStyle(fontWeight: FontWeight.w500))),
            ],
          ),
        );
      },
    );
  }

  void _showSettings(BuildContext context, AppLocalization l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.settings, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Language / Tilni tanlash', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLangOption(context, '🇺🇸', 'en', 'English'),
                  _buildLangOption(context, '🇷🇺', 'ru', 'Русский'),
                  _buildLangOption(context, '🇺🇿', 'uz', 'O\'zbek'),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white10),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.danger),
                title: Text(l10n.signOut, style: TextStyle(color: AppColors.danger)),
                onTap: () {
                  context.read<AuthBloc>().add(AuthLoggedOut());
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: Icon(Icons.delete_forever, color: AppColors.danger),
                title: Text(l10n.deleteAccount, style: TextStyle(color: AppColors.danger)),
                subtitle: Text('This action was requested. Warning: irreversible.'),
                onTap: () {
                  context.read<AuthBloc>().add(AuthDeleted());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLangOption(BuildContext context, String flag, String code, String label) {
    final currentLocale = Localizations.localeOf(context);
    final isSelected = currentLocale.languageCode == code;
    return GestureDetector(
      onTap: () {
        context.read<LanguageBloc>().add(LanguageChanged(Locale(code)));
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withAlpha(50) : Colors.transparent,
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.textCaption.withAlpha(50)),
              shape: BoxShape.circle,
            ),
            child: Text(flag, style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
