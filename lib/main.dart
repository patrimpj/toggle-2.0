import 'package:flutter/material.dart';
import 'package:untitled/toggle20.dart';

void main() {
  runApp(const MyApp());
}

// ───────────────────────────────────────────────────────────────
/// Root App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Toggle Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TogglePage(),
    );
  }
}

// ───────────────────────────────────────────────────────────────

// ───────────────────────────────────────────────────────────────
/// Toggle Page
class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage>
    with SingleTickerProviderStateMixin {
  bool isOn = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );

    _scale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
        reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
  }

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
      if (isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Custom Toggle Page"),
      ),
      body: Center(
        child: CustomToggle(),
      ),
    );
  }
}
