// lib/state/app_state.dart
// Global in-memory state — favorites + checklist + settings
// Uses InheritedWidget pattern — zero external packages required.

import 'package:flutter/material.dart';

class AppStateData {
  final Set<String> favoritePlaceIds;
  final Set<String> favoriteHotelNames;
  final Set<int> checkedItems;
  final String language;
  // Dark mode has been removed — app is light-only.

  const AppStateData({
    this.favoritePlaceIds = const {},
    this.favoriteHotelNames = const {},
    this.checkedItems = const {},
    this.language = 'en',
  });

  AppStateData copyWith({
    Set<String>? favoritePlaceIds,
    Set<String>? favoriteHotelNames,
    Set<int>? checkedItems,
    String? language,
  }) =>
      AppStateData(
        favoritePlaceIds: favoritePlaceIds ?? this.favoritePlaceIds,
        favoriteHotelNames: favoriteHotelNames ?? this.favoriteHotelNames,
        checkedItems: checkedItems ?? this.checkedItems,
        language: language ?? this.language,
      );
}

class AppStateNotifier extends ChangeNotifier {
  AppStateData _data = const AppStateData();
  AppStateData get data => _data;

  // Dark mode removed — toggleDarkMode no longer exists.
  void toggleLanguage() {
    _data = _data.copyWith(
        language: _data.language == 'en' ? 'gu' : 'en');
    notifyListeners();
  }

  void toggleFavoritePlace(String id) {
    final updated = Set<String>.from(_data.favoritePlaceIds);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    _data = _data.copyWith(favoritePlaceIds: updated);
    notifyListeners();
  }

  bool isPlaceFavorite(String id) => _data.favoritePlaceIds.contains(id);

  void toggleFavoriteHotel(String name) {
    final updated = Set<String>.from(_data.favoriteHotelNames);
    if (updated.contains(name)) {
      updated.remove(name);
    } else {
      updated.add(name);
    }
    _data = _data.copyWith(favoriteHotelNames: updated);
    notifyListeners();
  }

  bool isHotelFavorite(String name) => _data.favoriteHotelNames.contains(name);

  void toggleChecklistItem(int index) {
    final updated = Set<int>.from(_data.checkedItems);
    if (updated.contains(index)) {
      updated.remove(index);
    } else {
      updated.add(index);
    }
    _data = _data.copyWith(checkedItems: updated);
    notifyListeners();
  }

  void clearChecklist() {
    _data = _data.copyWith(checkedItems: {});
    notifyListeners();
  }

  void checkAllItems(int total) {
    _data = _data.copyWith(
        checkedItems: Set<int>.from(List.generate(total, (i) => i)));
    notifyListeners();
  }

  bool isChecked(int index) => _data.checkedItems.contains(index);
  int get checkedCount => _data.checkedItems.length;
}

class AppStateProvider extends InheritedNotifier<AppStateNotifier> {
  const AppStateProvider({
    super.key,
    required AppStateNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static AppStateNotifier of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'AppStateProvider not found in widget tree');
    return provider!.notifier!;
  }
}