import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/common_widgets/async_value_widget.dart%2012-59-52-104.dart';
import 'package:lifted/src/common_widgets/custom_image.dart';
import 'package:lifted/src/common_widgets/empty_placeholder_widget.dart';
import 'package:lifted/src/common_widgets/responsive_center.dart';
import 'package:lifted/src/common_widgets/responsive_two_column_layout.dart';
import 'package:lifted/src/constants/app_sizes.dart';
import 'package:lifted/src/features/workouts/data/fake_workouts_repository.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';
import 'package:lifted/src/features/workouts/presentation/home_app_bar/home_app_bar.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';

/// Shows the workout page for a given workout ID.
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.workoutId});
  final String workoutId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final workoutValue = ref.watch(workoutProvider(workoutId));
          return AsyncValueWidget<Workout?>(
            value: workoutValue,
            data: (workout) => workout == null
                ? EmptyPlaceholderWidget(
                    message: 'Workout not found'.hardcoded,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: WorkoutDetails(workout: workout),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

/// Shows all the workout details along with actions to:
class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: workout.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(workout.title,
                  style: Theme.of(context).textTheme.titleLarge),
              gapH8,
              Text(workout.description),
            ],
          ),
        ),
      ),
    );
  }
}
