/// * The workout identifier is an important concept and can have its own type.
typedef WorkoutID = String;

/// Class representing a workout.
class Workout {
  const Workout({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  /// Unique workout id
  final WorkoutID id;
  final String imageUrl;
  final String title;
  final String description;
}
