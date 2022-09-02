import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sence/helpers/secure_store_service.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/services/admob_service.dart';
import 'package:sence/services/socket_service.dart';
import 'package:sence/views/pages/get_answers_page.dart';
import 'package:sence/views/pages/give_answers_page.dart';
import 'package:sence/views/pages/home_page.dart';
import 'package:sence/views/widgets/custom_white_logo.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);
  static const List<Widget> _widgetList = <Widget>[
    HomePage(),
    GetAnswersPage(),
    GiveAnswersPage()
  ];
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  SocketService? _socket;
  SecureStoreService? _secureStoreService;
  BannerAd? _banner;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void connectSocket() async {
    var userId = await _secureStoreService!.readValue(key: 'id');
    await _socket!.connection(userId: userId.toString());
  }

  @override
  void initState() {
    super.initState();
    _socket = SocketService();
    _secureStoreService = SecureStoreService();
    connectSocket();
    userId();
    _createBannerAd();
  }

  _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  Future userId() async {
    var userId = await _secureStoreService!.readValue(key: 'id');
    final store = provider();
    store.userId = userId.toString();
  }

  provider() {
    final store = Provider.of<AuthProvider>(context, listen: false);
    return store;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: 'Ansayfa',
            activeIcon: Icon(Icons.question_mark, size: 35),
            icon: Icon(Icons.question_mark_outlined, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            tooltip: 'Gelen Cevaplar',
            activeIcon:
                Icon(Icons.keyboard_double_arrow_down_outlined, size: 35),
            icon: Icon(Icons.keyboard_double_arrow_down_outlined, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            tooltip: 'Dikkat Edelim Lütfen',
            activeIcon: Icon(Icons.keyboard_double_arrow_up_outlined, size: 35),
            icon: Icon(Icons.keyboard_double_arrow_up_outlined, size: 35),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(title: const CustomWhiteLogo()),
      body: Column(
        children: <Widget>[
          Expanded(
            child: NavigationPage._widgetList.elementAt(_selectedIndex),
          ),
          _banner != null
              ? SizedBox(
                  height: 53,
                  width: double.infinity,
                  child: AdWidget(ad: _banner!),
                )
              : const Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Text('şşş ordaki'),
                  ),
                )
        ],
      ),
    );
  }
}
