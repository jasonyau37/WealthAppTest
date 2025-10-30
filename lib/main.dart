import 'package:flutter/material.dart';

void main() { runApp(const InsureAiApp()); }

class InsureAiApp extends StatelessWidget { const InsureAiApp({super.key});

@override Widget build(BuildContext context) { return MaterialApp( title: 'InsureAI Dashboard (test123)', debugShowCheckedModeBanner: false, theme: ThemeData( primaryColor: const Color(0xFF0A6ED1), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6ED1)), scaffoldBackgroundColor: const Color(0xFFF6FAFC), ), home: const DashboardScreen(), ); } }

class DashboardScreen extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }

class DashboardScreen2 extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }

class DashboardScreen3 extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }

class DashboardScreen4 extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }

class DashboardScreen5 extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }
