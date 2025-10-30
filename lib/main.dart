import 'package:flutter/material.dart';

void main() { runApp(const InsureAiApp()); }

class InsureAiApp extends StatelessWidget { const InsureAiApp({super.key});

@override Widget build(BuildContext context) { return MaterialApp( title: 'InsureAI Dashboard', debugShowCheckedModeBanner: false, theme: ThemeData( primaryColor: const Color(0xFF0A6ED1), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6ED1)), scaffoldBackgroundColor: const Color(0xFFF6FAFC), ), home: const DashboardScreen(), ); } }

class DashboardScreen extends StatelessWidget { const DashboardScreen({super.key});

@override Widget build(BuildContext context) { return LayoutBuilder(builder: (context, constraints) { final isWide = constraints.maxWidth >= 1000; return Scaffold( drawer: isWide ? null : const _AppDrawer(), body: Row(children: [ if (isWide) const _LeftNav(), Expanded( child: SafeArea( child: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ _TopHeader(), SizedBox(height: 18), _OverviewRow(), SizedBox(height: 22), _LowerRow(), ], ), ), ), ), ]), ); }); } }

class _TopHeader extends StatelessWidget { const _TopHeader();

@override Widget build(BuildContext context) { final theme = Theme.of(context); return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ Expanded( child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text('Welcome back, Agent Lee!', style: theme.textTheme.headline5?.copyWith( fontWeight: FontWeight.w800, color: Colors.black87, )), const SizedBox(height: 6), Text("Here's your snapshot for ${_formatDate(DateTime.now())}.", style: theme.textTheme.bodyMedium ?.copyWith(color: Colors.black54)), ]), ), ElevatedButton.icon( onPressed: () {}, icon: const Icon(Icons.add), label: const Text('+ Add Task'), style: ElevatedButton.styleFrom( backgroundColor: const Color(0xFF0A6ED1), padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), ), ), ]); }

static String _formatDate(DateTime d) => '${_monthName(d.month)} ${d.day}, ${d.year}'; static String _monthName(int m) { const names = [ '', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' ]; return names[m]; } }

class _OverviewRow extends StatelessWidget { const _OverviewRow();

@override Widget build(BuildContext context) { return Wrap( spacing: 18, runSpacing: 12, children: const [ _SummaryCard(title: 'Hot Leads', value: '7', accent: Color(0xFF0A6ED1)), _SummaryCard( title: 'Upcoming Renewals', value: '12', accent: Color(0xFF5ED0EA)), _SummaryCard(title: 'MDRT Progress', value: '65%', accent: Color(0xFFFFD400)), ], ); } }

class _SummaryCard extends StatelessWidget { final String title; final String value; final Color accent; const _SummaryCard( {required this.title, required this.value, required this.accent});

@override Widget build(BuildContext context) { return Container( width: 300, height: 110, padding: const EdgeInsets.all(16), decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [ BoxShadow( color: Color.fromRGBO(16, 24, 40, 0.04), blurRadius: 10, offset: Offset(0, 6)), ], ), child: Row(children: [ Container( width: 6, height: double.infinity, decoration: BoxDecoration( color: accent, borderRadius: const BorderRadius.only( topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)), ), ), const SizedBox(width: 12), Expanded( child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(title, style: const TextStyle( fontWeight: FontWeight.w600, color: Colors.black54)), const Spacer(), Text(value, style: const TextStyle( fontSize: 28, fontWeight: FontWeight.bold)), ]), ), ]), ); } }

class _LowerRow extends StatelessWidget { const _LowerRow();

@override Widget build(BuildContext context) { return Wrap(spacing: 18, runSpacing: 18, children: const [ SizedBox( width: 640, child: _CardBox( child: _TasksList(), ), ), SizedBox( width: 640, child: _CardBox( child: _ActivityFeed(), ), ), ]); } }

class _CardBox extends StatelessWidget { final Widget child; const _CardBox({required this.child});

@override Widget build(BuildContext context) { return Container( padding: const EdgeInsets.all(18), margin: const EdgeInsets.only(bottom: 6), decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [ BoxShadow( color: Color.fromRGBO(16, 24, 40, 0.04), blurRadius: 10, offset: Offset(0, 6)) ], ), child: child, ); } }

class _TasksList extends StatelessWidget { const _TasksList();

@override Widget build(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [ Text("Today's Tasks", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)), SizedBox(height: 12), _TaskCheckbox(label: 'Follow up with John Doe'), _TaskCheckbox(label: 'Prepare proposal for Jane Smith'), _TaskCheckbox(label: 'Send birthday message to Bob Chan'), ]); } }

class _TaskCheckbox extends StatefulWidget { final String label; const _TaskCheckbox({required this.label});

@override State<_TaskCheckbox> createState() => _TaskCheckboxState(); }

class _TaskCheckboxState extends State<_TaskCheckbox> { bool checked = false; @override Widget build(BuildContext context) { return Padding( padding: const EdgeInsets.symmetric(vertical: 8.0), child: Row(children: [ Checkbox(value: checked, onChanged: (v) => setState(() => checked = v ?? false)), Expanded(child: Text(widget.label)), ]), ); } }

class _ActivityFeed extends StatelessWidget { const _ActivityFeed();

@override Widget build(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ const Text("AI Activity Feed", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)), const SizedBox(height: 12), _ActivityItem( icon: Icons.phone, title: RichText( text: TextSpan( style: const TextStyle(color: Colors.black87, fontSize: 14), children: [ const TextSpan(text: 'Call with '), TextSpan(text: 'Jane Smith', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A6ED1))), const TextSpan(text: ' summarized. AI suggests updating her income. '), WidgetSpan( child: Container( padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), margin: EdgeInsets.only(left: 6), decoration: BoxDecoration( color: Color(0xFFE8F7EB), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFFBEE8C8)), ), child: const Text('Approve', style: TextStyle(color: Color(0xFF1B7A3A), fontSize: 12)), ), ), ], ), ), subtitle: '5 minutes ago', ), const SizedBox(height: 8), _ActivityItem( icon: Icons.description, title: RichText( text: const TextSpan( style: TextStyle(color: Colors.black87, fontSize: 14), children: [ TextSpan(text: 'New policy for '), TextSpan(text: 'Bob Chan', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A6ED1))), TextSpan(text: ' added via OCR scan.'), ], ), ), subtitle: '1 hour ago', ), ]); } }

class _ActivityItem extends StatelessWidget { final IconData icon; final Widget title; final String subtitle; const _ActivityItem({required this.icon, required this.title, required this.subtitle});

@override Widget build(BuildContext context) { return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ Container( padding: const EdgeInsets.all(8), margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 18, color: Colors.pink.shade400), ), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ title, const SizedBox(height: 6), Text(subtitle, style: const TextStyle(color: Colors.black45)), ])), ]); } }

class _LeftNav extends StatelessWidget { const _LeftNav();

@override Widget build(BuildContext context) { return Container( width: 220, padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12), decoration: const BoxDecoration( color: Colors.white, border: Border(right: BorderSide(color: Color(0xFFE8EEF3), width: 1)), ), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Padding( padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [ Container( width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF0A6ED1), borderRadius: BorderRadius.circular(6)), child: const Center(child: Text('IA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), ), const SizedBox(width: 10), const Text('InsureAI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), ]), ), const SizedBox(height: 20), Expanded( child: ListView(padding: const EdgeInsets.symmetric(vertical: 8), children: const [ _NavTile(label: 'Dashboard', icon: Icons.dashboard, active: true), _NavTile(label: 'Clients', icon: Icons.people), _NavTile(label: 'Policies', icon: Icons.folder), _NavTile(label: 'Analytics', icon: Icons.bar_chart), _NavTile(label: 'Calculators', icon: Icons.calculate), _NavTile(label: 'Inbox', icon: Icons.mail), ]), ), const SizedBox(height: 8), const _NavTile(label: 'Settings', icon: Icons.settings, dense: true), ]), ); } }

class _AppDrawer extends StatelessWidget { const _AppDrawer();

@override Widget build(BuildContext context) { return Drawer(child: Column(children: [ DrawerHeader(child: Row(children: [ Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFF0A6ED1), borderRadius: BorderRadius.circular(6)), child: const Center(child: Text('IA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))), const SizedBox(width: 12), const Text('InsureAI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), ])), const Divider(height: 1), Expanded(child: ListView(children: const [ _NavTile(label: 'Dashboard', icon: Icons.dashboard, active: true), _NavTile(label: 'Clients', icon: Icons.people), _NavTile(label: 'Policies', icon: Icons.folder), _NavTile(label: 'Analytics', icon: Icons.bar_chart), _NavTile(label: 'Calculators', icon: Icons.calculate), _NavTile(label: 'Inbox', icon: Icons.mail), ])), const Divider(height: 1), const Padding(padding: EdgeInsets.all(12), child: _NavTile(label: 'Settings', icon: Icons.settings, dense: true)), ])); } }

class _NavTile extends StatelessWidget { final String label; final IconData icon; final bool active; final bool dense; const _NavTile({required this.label, required this.icon, this.active = false, this.dense = false});

@override Widget build(BuildContext context) { return Padding( padding: EdgeInsets.symmetric(vertical: dense ? 6 : 8.0), child: ListTile( dense: dense, leading: Icon(icon, color: active ? const Color(0xFF0A6ED1) : Colors.black54), title: Text(label, style: TextStyle(fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: active ? const Color(0xFF0A6ED1) : Colors.black87)), tileColor: active ? Colors.blue.shade50 : null, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onTap: () {}, ), ); } }
