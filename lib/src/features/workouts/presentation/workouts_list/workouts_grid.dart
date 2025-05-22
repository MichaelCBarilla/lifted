import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifted/src/common_widgets/async_value_widget.dart%2012-59-52-104.dart';
import 'package:lifted/src/constants/app_sizes.dart';
import 'package:lifted/src/features/workouts/data/fake_workouts_repository.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';
import 'package:lifted/src/features/workouts/presentation/workouts_list/workout_card.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';
import 'package:lifted/src/routing/app_router.dart';

/// A widget that displays the list of workouts that match the search query.
class WorkoutsGrid extends ConsumerWidget {
  const WorkoutsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsListValue = ref.watch(workoutsListStreamProvider);
    return AsyncValueWidget<List<Workout>>(
      value: workoutsListValue,
      data: (workouts) => workouts.isEmpty
          ? Center(
              child: Text(
                'No workouts found'.hardcoded,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : WorkoutsLayoutGrid(
              itemCount: workouts.length,
              itemBuilder: (_, index) {
                final workout = workouts[index];
                return WorkoutCard(
                  workout: workout,
                  onPressed: () => context.goNamed(
                    AppRoute.workout.name,
                    pathParameters: {'id': workout.id},
                  ),
                );
              },
            ),
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class WorkoutsLayoutGrid extends StatelessWidget {
  const WorkoutsLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
