import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/core/models/app_router_type.dart';
import 'package:travel_guide/features/onboading/onboarding_view_model.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      appBar: isEditing
          ? AppBar(title: const Text('Change home location'))
          : null,
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
