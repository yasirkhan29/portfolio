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
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.amber,
            color: Color.fromARGB(255, 240, 241, 215),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/beackgournd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              key: _headerGlobalKey,
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Container(
                    width: 40,
                    height: 40,
                    color: AppColors.yellow,
                    child: Image.asset('lib/assets/logo.jpg'),
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.black87, Colors.transparent],
                  ),
                ),
              ),
              bottom:  PreferredSize(
                preferredSize: Size.fromHeight(500),
                child: Header(),
              ),
              actions: [
                Row(
                  children: [
                    MaterialButton(
                      onPressed: _scrollToAbout,
                      child: const Text('About Me',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    MaterialButton(
                      onPressed: _scrollToStatistics,
                      child: const Text('Experience',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    MaterialButton(
                      onPressed: _scrollToWorkingProcess,
                      child: const Text('Process',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    MaterialButton(
                      onPressed: _scrollToRecentProjects,
                      child: const Text('Portfolio',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _scrollToContactUs,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12)),
                      child: const Text('Contact Me',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Container(
                  width: 100,
                  height: 100,
                  color: AppColors.yellow,
                  child: Image.asset('lib/assets/logo.jpg'),
                ),
              ),
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
                    onTap: () => launch(AppConstants.linkedin),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/beackgournd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              key: _headerGlobalKey,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              leading: Builder(
                builder: (context) => InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: AppColors.yellow,
                      child: Image.asset('lib/assets/logo.jpg'),
                    ),
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.black87, Colors.transparent],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(350),
                child: Header(),
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
        SliverToBoxAdapter(key: _aboutGlobaleKey, child:  About()),
        SliverToBoxAdapter(key: _statisticsGlobaleKey, child:  Statistics()),
        SliverToBoxAdapter(
            key: _workingProcessGlobaleKye, child:  WorkingProcess()),
        SliverToBoxAdapter(
            key: _recentProjectsGlobaleKey, child:  MyProjects()),
        SliverToBoxAdapter(key: _contactUsGlobaleKey, child:  ContactUs()),
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
          backgroundColor: Colors.amber,
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

  @override
  void dispose() {
    _scrollController.dispose();
    _fabStream.close();
    super.dispose();
  }
}
