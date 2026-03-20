import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: FutureBuilder<String>(
            future: rootBundle.loadString('policies/sports_merge/privacy_policy.html'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading policy:\n${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.03),
                      border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.05)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: Html(
                      data: snapshot.data,
                      style: {
                        "body": Style(
                          color: const Color(0xFFA0A0A0),
                          fontSize: FontSize(16.0),
                          lineHeight: LineHeight.em(1.6),
                        ),
                        "strong": Style(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        "a": Style(
                          color: const Color(0xFF4169e1),
                          textDecoration: TextDecoration.none,
                        ),
                      },
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
