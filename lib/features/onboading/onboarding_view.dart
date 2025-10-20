import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_guide/features/onboading/onboarding_view_model.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewmodel.loadInit();
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
