import 'package:flutter/material.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';

/// Search field used to filter workouts by name
class WorkoutsSearchTextField extends StatefulWidget {
  const WorkoutsSearchTextField({super.key});

  @override
  State<WorkoutsSearchTextField> createState() =>
      _WorkoutsSearchTextFieldState();
}

class _WorkoutsSearchTextFieldState extends State<WorkoutsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            hintText: 'Search workouts'.hardcoded,
            icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      // TODO: Clear search state
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          // TODO: Implement onChanged
          onChanged: null,
        );
      },
    );
  }
}
