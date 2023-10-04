import 'package:agile02/page/homepage.dart';
import 'package:agile02/page/login.dart';
import 'package:agile02/page/register.dart';
import 'package:agile02/page/wd.dart';
import 'package:agile02/providers/about_akun.dart';
import 'package:agile02/temp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainHome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get usernameInputRegister => null;

  @override
  Widget build(BuildContext context) {
    final aboutprov = Provider.of<AboutAkun>(context);
    return Template(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Masukkan semua page yng dibuat kemari

            // Daftar
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Register(
                            usernameInputRegister: usernameInputRegister ??
                                TextEditingController())));
              },
              child: Text("Daftar"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Login
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Login()));
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Penarikan dana
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => WD()));
              },
              child: Text("Penarikan Dana"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Button Contoh

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => Payment()));
            //     },
            //     child: Text("Pay")),
            // const SizedBox(
            //   height: 10,
            // ),

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (_) => About(
            //                     username: aboutprov.data[0],
            //                   )));
            //     },
            //     child: Text("About")),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MainHome()));
                },
                child: Text("Home")),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => UtamaHome()));
                },
                child: Text("MainHome")),
          ],
        ),
      ),
    );
  }
}
