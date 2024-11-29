enum CompleteFilter{
  pending, complete
}

extension CompleteFilterExtension on CompleteFilter {
  String get label {
    switch (this) {
      case CompleteFilter.pending:
        return 'Pending';
      case CompleteFilter.complete:
        return 'Completed';
    }
  }
}