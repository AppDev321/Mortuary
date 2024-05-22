const int numberOfInitiallyLoadedItems = 60;
const int numberOfLazyLoadedItems = 30;

extension CustomListExtension<T> on List<T> {
  bool get hasMoreThanInitiallyLoadedItems => length > 40;

  List<T> get initialDisplayList {
    if (numberOfInitiallyLoadedItems > length) {
      return sublist(0, length);
    }
    return sublist(0, numberOfInitiallyLoadedItems);
  }

  /// Decides the number of items that will be included in the lazily loaded list.
  /// The number can either be 20 or equal to the difference between the number of items
  /// in [displayList] and [sourceList].
  List<T> lazyLoadedDisplayList(int displayListLength, int difference) {
    // Checks if the difference between [displayList] and [sourceList] is greater than
    // the number of items that will be loaded lazily.
    if (difference > numberOfLazyLoadedItems) {
      return sublist(
          displayListLength, displayListLength + numberOfLazyLoadedItems);
    }

    // Either the difference between [displayList] and [sourceList] is either
    // equal to the number of lazily loaded items i.e, 20, or is less than 20.
    // In either case, difference should be used as an increment in the number of
    // items from the sublist.
    return sublist(displayListLength, displayListLength + difference);
  }
}
