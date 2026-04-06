import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../domain/repositories/auth_repository.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final List<String> _interests = ['Fitness', 'Productivity', 'Learning', 'Mindfulness', 'Career', 'Habits'];
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Personalize Your Journey',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Select your interests to curate the best challenges for you.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textCaption),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _interests.map((interest) {
                    final isSelected = _selected.contains(interest);
                    return ChoiceChip(
                      label: Text(interest),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selected.add(interest);
                          } else {
                            _selected.remove(interest);
                          }
                        });
                      },
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.cardBackground,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textCaption,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: _selected.isEmpty ? null : _handleComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleComplete() async {
    final state = context.read<AuthBloc>().state;
    if (state is AuthAuthenticated) {
      final updatedUser = state.user.copyWith(interests: _selected.toList());
      await context.read<AuthRepository>().updateProfile(updatedUser);
      context.read<AuthBloc>().add(AuthLoggedIn(user: updatedUser));
    }
  }
}
