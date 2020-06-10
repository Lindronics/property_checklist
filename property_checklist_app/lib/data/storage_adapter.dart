abstract class StorageAdapter<T> {
  List<T> getItems();
  T getItem(int i);
  int getLength();
  void addItem(T item);
}

class ListStorageAdapter<T> extends StorageAdapter<T> {
  List<T> _items;

  ListStorageAdapter(List<T> items) {
    _items = items;
  }

  @override
  List<T> getItems() {
    return _items;
  }

  @override
  T getItem(int i) {
    return _items[i];
  }

  @override
  int getLength() {
    return _items.length;
  }

  @override
  void addItem(T item) {
    _items.add(item);
  }
}