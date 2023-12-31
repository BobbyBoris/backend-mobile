import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agile02/providers/data_provider.dart';
import 'package:agile02/providers/pageProv.dart';

class Template extends StatefulWidget {
  Widget child;
  Template({super.key, required this.child});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  late BannerAd _bannerAd;
  bool _isBannerReady = false;
  bool _isBannerEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadBannerStatus(); // Tambahkan ini untuk memeriksa status penonaktifan
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DataProvider>(context);
    final pageprov = Provider.of<PageProv>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/title.png'),
        actions: [
          if (user.isLoggedIn)
            PopupMenuButton<String>(
              onSelected: (String value) {},
              itemBuilder: (BuildContext context) => [],
            ),
          IconButton(
            icon: Icon(
                _isBannerEnabled ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              _toggleBannerAdVisibility();
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            (_isBannerEnabled ? _bannerAd.size.height.toDouble() : 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/footer.png'),
            ),
            widget.child,
            if (_isBannerEnabled && _isBannerReady)
              Positioned(
                bottom: 0,
                left:
                    (MediaQuery.of(context).size.width - _bannerAd.size.width) /
                        2,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _isBannerReady = false;
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  void _toggleBannerAdVisibility() {
    setState(() {
      _isBannerEnabled = !_isBannerEnabled;
      _saveBannerStatus();
      if (!_isBannerEnabled) {
        _disableBannerAdPermanently();
      }
    });
  }

  void _disableBannerAdPermanently() {
    setState(() {
      _isBannerReady = false;
    });
    _bannerAd.dispose();
  }

  void _saveBannerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bannerStatus', _isBannerEnabled);
  }

  void _loadBannerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? bannerStatus = prefs.getBool('bannerStatus');
    if (bannerStatus != null) {
      setState(() {
        _isBannerEnabled = bannerStatus;
      });
    }
  }
}
