import 'package:chatapp/modules/Login/HomeScreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'OnboardingScreen';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Rice Detection System',
      'desc': 'Rice Detection System\nIn Single Click',
      'image': 'assets/images/onboard1.png',
    },
    {
      'title': 'Rice Detection System',
      'desc': 'Detailed report of\ndiagnosis and treatment',
      'image': 'assets/images/onboard2.png',
    },
    {
      'title': 'Rice Detection System',
      'desc': 'AI-based Rice Quality\nAnalysis Tool',
      'image': 'assets/images/onboard3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.jpg', // use your background image here
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("WELCOME", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Language"),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: onboardingData.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(onboardingData[index]['image']!, height: 80),
                              const SizedBox(height: 20),
                              Text(
                                onboardingData[index]['title']!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                onboardingData[index]['desc']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  onboardingData.length,
                                      (i) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: _currentPage == i ? Colors.blue : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text("Login", style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("Next"),
                        onPressed: () {
                          if (_currentPage < onboardingData.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // Final screen action (e.g., go to home)
                            Navigator.pushReplacementNamed(context, HomeScreen.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
