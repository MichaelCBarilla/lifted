import 'package:flutter/material.dart';
import 'package:lifted/src/common_widgets/responsive_center.dart';
import 'package:lifted/src/constants/app_sizes.dart';
import 'package:lifted/src/features/workouts/presentation/home_app_bar/home_app_bar.dart';
import 'package:lifted/src/features/workouts/presentation/workouts_list/workouts_grid.dart';
import 'package:lifted/src/features/workouts/presentation/workouts_list/workouts_search_text_field.dart';

/// Shows the list of workouts with a search field at the top.
class WorkoutsListScreen extends StatefulWidget {
  const WorkoutsListScreen({super.key});

  @override
  State<WorkoutsListScreen> createState() => _WorkoutsListScreenState();
}

class _WorkoutsListScreenState extends State<WorkoutsListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: WorkoutsSearchTextField(),
          ),
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: WorkoutsGrid(),
          ),
        ],
      ),
    );
  }
}
