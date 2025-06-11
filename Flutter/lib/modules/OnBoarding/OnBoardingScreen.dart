import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoardingScreen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Rice Detection System",
      "subtitle": "Rice Detection\nSystem\nIn Single Click",
      "icon": "https://cdn-icons-png.flaticon.com/512/565/565547.png", // replace with your asset or network icon
    },
    {
      "title": "Fast & Accurate",
      "subtitle": "Results\nwithin seconds",
      "icon": "https://cdn-icons-png.flaticon.com/512/2721/2721279.png",
    },
    {
      "title": "User Friendly",
      "subtitle": "Easy to use\ninterface",
      "icon": "https://cdn-icons-png.flaticon.com/512/3523/3523063.png",
    },
  ];

  void _nextPage() {
    if (_currentIndex < pages.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      // Navigate to login or home screen
      Navigator.pushReplacementNamed(context, 'LoginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/close-up-wheat-ear-field_23-2150706970.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("WELCOME",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text("Language",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ),

          // PageView with content
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    page['title']!,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          page['icon']!,
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page['subtitle']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(pages.length, (i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentIndex == i ? 10 : 8,
                              height: _currentIndex == i ? 10 : 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == i
                                    ? Colors.black
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom buttons
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'LoginScreen');
                  },
                  child: const Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                      _currentIndex == pages.length - 1 ? "Done" : "Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
