enum ListOrder{
  byPriority, byDate
}

extension ListOrderExtension on ListOrder {
  String get label {
    switch (this) {
      case ListOrder.byPriority:
        return 'By Priority';
      case ListOrder.byDate:
        return 'By Date';
    }
  }
}