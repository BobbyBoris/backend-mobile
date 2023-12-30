import 'package:agile02/MainHome.dart';
import 'package:agile02/page/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
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
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            _bannerAd.size.height.toDouble(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/footer.png'),
            ),
            widget.child,
            if (_isBannerReady)
              Positioned(
                bottom: 0,
                left:
                    (MediaQuery.of(context).size.width - _bannerAd.size.width) /
                        2, //agar banner ad di tengah
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
}
