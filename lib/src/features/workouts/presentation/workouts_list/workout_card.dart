import 'package:flutter/material.dart';
import 'package:lifted/src/common_widgets/custom_image.dart';
import 'package:lifted/src/constants/app_sizes.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';

import 'package:lifted/src/utils/currency_formatter.dart';

/// Used to show a single workout inside a card.
class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout, this.onPressed});
  final Workout workout;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const workoutCardKey = Key('workout-card');

  @override
  Widget build(BuildContext context) {
    // TODO: Inject formatter
    return Card(
      child: InkWell(
        key: workoutCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImage(imageUrl: workout.imageUrl),
              gapH8,
              const Divider(),
              gapH8,
              Text(workout.title,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
