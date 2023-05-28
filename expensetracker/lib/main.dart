import 'package:flutter/material.dart';

import 'package:expensetracker/expenses.dart';

var expenseColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var expenseDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: expenseDarkColorScheme),
      home: const Expenses(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: expenseColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: expenseColorScheme.onPrimaryContainer,
            foregroundColor: expenseColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: expenseColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: expenseColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: expenseColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      themeMode: ThemeMode.light,
    ),
  );
}
