import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/home_screen/home_screen.dart';

final counterProvider = StateNotifierProvider<CounterProvider, int>(
  (ref) => CounterProvider(),
);

final class CounterProvider extends StateNotifier<int> {
  CounterProvider() : super(0);

  void increment() => state++;

  void decrement() {
    if (state <= 0) return;
    state--;
  }
}

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
