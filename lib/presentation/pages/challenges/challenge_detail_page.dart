import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/theme/colors.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String title;
  final int totalDays;
  final int currentDay;

  const ChallengeDetailPage({
    super.key,
    required this.title,
    required this.totalDays,
    required this.currentDay,
  });

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProgressCard(context),
            const SizedBox(height: 32),
            _buildSubmissionCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    double progress = widget.currentDay / widget.totalDays;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Day ${widget.currentDay}', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.primary)),
              Text('of ${widget.totalDays}', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: AppColors.textCaption.withAlpha(20),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text('${(progress * 100).toInt()}% Completed', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildSubmissionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.primary.withAlpha(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Today\'s Proof', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Upload a photo to verify your completion.', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.textCaption.withAlpha(20), style: BorderStyle.solid),
              ),
              child: _image == null 
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined, size: 40, color: AppColors.textCaption),
                        const SizedBox(height: 8),
                        Text('Tap to select', style: TextStyle(color: AppColors.textCaption)),
                      ],
                    )
                  : ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.file(File(_image!.path), fit: BoxFit.cover, errorBuilder: (c, e, s) => Center(child: Text("Image selected")))),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _image == null || _submitting ? null : _submit,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
            child: _submitting ? CircularProgressIndicator(color: Colors.white) : Text('Mark as Done'),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _image = image);
    }
  }

  void _submit() async {
    setState(() => _submitting = true);
    HapticFeedback.heavyImpact(); // Micro-interaction for completion
    
    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 8), Text("Challenge updated! XP earned: +10")]),
        backgroundColor: AppColors.secondary,
      ));
      Navigator.pop(context);
    }
  }
}
