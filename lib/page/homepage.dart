import 'package:agile02/page/about.dart';
import 'package:agile02/page/listcreator.dart';
import 'package:agile02/page/login.dart';
import 'package:agile02/page/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'analytics.dart';
import '../MainHome.dart';
import '../providers/provUtama.dart';
import '../temp.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController _usernameInputController = TextEditingController();
  Analytics firebaseAnalytic = Analytics();

  @override
  void initState() {
    super.initState();
    Provider.of<ProvUtama>(context, listen: false).updateTotalPendapatan();
    Provider.of<ProvUtama>(context, listen: false).earlyAll();

    // Cek apakah pencarian sebelumnya telah dilakukan
  }

  @override
  Widget build(BuildContext context) {
    final mainprov = Provider.of<ProvUtama>(context);
    var berbagi;
    return Template(
      child: SingleChildScrollView(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      firebaseAnalytic.testEventlog(
                          "Cari"); // Add this line for analytics event
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Template(child: Listacc())),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Cari",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff22A62F)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)))),
                      onPressed: () {
                        firebaseAnalytic.testEventlog("Login");
                        void checkLastVisitedUsername() async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? loginUser = prefs.getString('lastLoginUser');
                          if (loginUser == null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          } else if (loginUser != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Login kembali melalui shared pref"),
                              duration: Duration(milliseconds: 900),
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UtamaHome()),
                            );
                          }
                        }

                        checkLastVisitedUsername();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ))
                ]),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png"),
                const Text("Berbagi kebaikan dengan setiap sumbangan.",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Quicksand")),
                const Text.rich(TextSpan(
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Quicksand"),
                    children: [
                      TextSpan(text: "dengan "),
                      TextSpan(
                          text: "BagiBagi,",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " kini anda dapat memberikan support ke kreator favorit anda dengan berbagai macam jenis pembayaran! mari berbagi kebaikan untuk semua di "),
                      TextSpan(
                          text: "BagiBagi.id",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ])),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _usernameInputController,
                          decoration: InputDecoration(
                              border: null, hintText: "bagibagi.id/"),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                            onPressed: () async {
                              firebaseAnalytic.testEventlog("Buat_Akun");
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Register(
                                          usernameInputRegister:
                                              _usernameInputController)));

                              _usernameInputController.clear();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff22A62F)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)))),
                            child: Text("Buat Akun!")),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
