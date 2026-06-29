import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/ui/responsive_widget.dart';

import 'about.dart';
import 'contact_us.dart';
import 'footer.dart';
import 'header.dart';
import 'icon.dart';
import 'my_projects.dart';
import 'statistics.dart';
import 'working_process.dart';
import '../config/colors.dart';
import '../config/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _headerGlobalKey = GlobalKey();
  final _aboutGlobaleKey = GlobalKey();
  final _statisticsGlobaleKey = GlobalKey();
  final _workingProcessGlobaleKye = GlobalKey();
  final _recentProjectsGlobaleKey = GlobalKey();
  final _contactUsGlobaleKey = GlobalKey();
  final _scrollController = ScrollController();
  final _fabStream = StreamController<bool>();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate a delay (you can replace this with real async operations)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });

    _scrollController.addListener(() {
      _fabStream.sink.add(_scrollController.offset > 500);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.primaryDark,
            color: AppColors.white,
          ),
        ),
      );
    }

    return ResponsiveWidget(
      desktopScreen: _buildDesktopLayout(),
      mobileScreen: _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Container(
        decoration: _backgroundDecoration(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              key: _headerGlobalKey,
              toolbarHeight: 100,
              backgroundColor: AppColors.overlay,
              title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .15),
                child: _buildLogo(size: 46),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black,
                      AppColors.black.withValues(alpha: .94),
                      AppColors.black.withValues(alpha: .72),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(400),
                child: const Header(),
              ),
              actions: [
                Row(
                  children: [
                    _buildNavButton('About Me', _scrollToAbout),
                    _buildNavButton('Experience', _scrollToStatistics),
                    _buildNavButton('Process', _scrollToWorkingProcess),
                    _buildNavButton('Portfolio', _scrollToRecentProjects),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _scrollToContactUs,
                      child: const Text('Contact Me',
                          style: TextStyle(
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .15),
              ],
            ),
            ..._slivers(),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildLogo(size: 100),
              const Divider(),
              ListTile(
                onTap: _scrollToAbout,
                title: const Text('About Me',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: _scrollToStatistics,
                title: const Text('Experience',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: _scrollToWorkingProcess,
                title: const Text('Process',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: _scrollToRecentProjects,
                title: const Text('Portfolio',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              ListTile(
                title: ElevatedButton(
                  onPressed: _scrollToContactUs,
                  child: const Text('Contact Me',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => launchUrl(Uri.parse(AppConstants.linkedin)),
                    child: AppIcon('lib/assets/linkedin.png',
                        color: AppColors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: _backgroundDecoration(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              key: _headerGlobalKey,
              centerTitle: true,
              backgroundColor: AppColors.overlay,
              leading: Builder(
                builder: (context) => InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildLogo(size: 42),
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black,
                      AppColors.black.withValues(alpha: .94),
                      AppColors.black.withValues(alpha: .72),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(300),
                child: const Header(),
              ),
            ),
            ..._slivers(),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  List<Widget> _slivers() => [
        SliverToBoxAdapter(key: _aboutGlobaleKey, child: const About()),
        SliverToBoxAdapter(key: _statisticsGlobaleKey, child:  Statistics()),
        SliverToBoxAdapter(
            key: _workingProcessGlobaleKye, child: const WorkingProcess()),
        SliverToBoxAdapter(
            key: _recentProjectsGlobaleKey, child: const MyProjects()),
        SliverToBoxAdapter(key: _contactUsGlobaleKey, child: const ContactUs()),
        SliverToBoxAdapter(child: Footer()),
      ];
 Widget _buildFab() {
    return StreamBuilder<bool>(
      stream: _fabStream.stream,
      builder: (_, data) {
        final bool showFab = data.hasData && data.data!;
        return AnimatedOpacity(
          opacity: showFab ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: FloatingActionButton(
          backgroundColor: AppColors.primary,
             onPressed: () {
                    _scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }, // make sure user cannot click when button hidden
            mini: true,
            child: AppIcon('lib/assets/up.png', size: 20),
          ),
        );
      },
    );
  }


  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  void _scrollToAbout() => _scrollTo(_aboutGlobaleKey);
  void _scrollToStatistics() => _scrollTo(_statisticsGlobaleKey);
  void _scrollToWorkingProcess() => _scrollTo(_workingProcessGlobaleKye);
  void _scrollToRecentProjects() => _scrollTo(_recentProjectsGlobaleKey);
  void _scrollToContactUs() => _scrollTo(_contactUsGlobaleKey);

  Widget _buildLogo({required double size}) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: .18)),
      ),
      child: ClipOval(
        child: Image.asset('lib/assets/logo.jpg', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNavButton(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Text(title),
    );
  }

  BoxDecoration _backgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF091010),
          Color(0xFF0F1616),
          Color(0xFF101919),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabStream.close();
    super.dispose();
  }
}
