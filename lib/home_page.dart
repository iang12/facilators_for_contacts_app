import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void launchEmail({
    required String email,
    String subject = 'Contato',
    String bodyMessage = 'Olá, eu gostaria de entrar de falar com você!',
  }) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': bodyMessage,
      },
    );

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      debugPrint('Could not launch ${params.path}');
    }
  }

  void launchTel({
    required String numberPhone,
  }) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: numberPhone,
    );

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      debugPrint('Error occured trying to call that number.');
    }
  }

  void launchMapsToNavigate({
    required String lat,
    required String lng,
  }) async {
    final Uri params = Uri.parse('google.navigation:q=$lat,$lng&mode=d');

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      debugPrint('Couldn launch Map');
    }
  }

  void launchSms({
    required String numberPhone,
    String message = 'Olá, eu gostaria de entrar em contato!',
  }) async {
    final Uri params = Uri(
      path: numberPhone,
      scheme: 'sms',
      queryParameters: {
        'body': message,
      },
    );

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      debugPrint('Could not launch ${params.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                launchTel(numberPhone: '+5586994324465');
              },
              child: const Text("Make A Call"),
            ),
            ElevatedButton(
              onPressed: () {
                launchSms(
                  numberPhone: '+91888888888',
                  message: 'Hi Welcome to Coders,',
                );
              },
              child: const Text("Send A SMS"),
            ),
            ElevatedButton(
              onPressed: () {
                launchEmail(
                  email: 'ian@fteam.dev',
                  bodyMessage: 'This is a test email body',
                  subject: 'Hi Welcome to Coders,',
                );
              },
              child: const Text("Send A Email"),
            ),
            ElevatedButton(
              onPressed: () {
                launchMapsToNavigate(
                  lat: '-3.823216',
                  lng: '-38.481700',
                );
              },
              child: const Text("Go to Maps"),
            ),
          ],
        ),
      ),
    );
  }
}
