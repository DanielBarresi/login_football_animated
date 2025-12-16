import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/animations.dart';
import '../data/bg_data.dart';
import '../utils/text_utils.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<Map<String, String>> images = [
    {'path': 'assets/bg1.jpg', 'label': 'Sport & Energia'},
    {'path': 'assets/bg2.jpg', 'label': 'Squadra & Passione'},
    {'path': 'assets/bg5.jpg', 'label': 'Allenamento'},
    {'path': 'assets/bg6.jpg', 'label': 'Vittoria'},
    {'path': 'assets/bg8.jpg', 'label': 'Determinazione'},
    {'path': 'assets/bg1.jpg', 'label': 'Benvenuto'},
  ];
  int currentImage = 0;

  @override
  void initState() {
    super.initState();
    // Cambio immagine ogni 3 secondi
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return false;
      setState(() {
        currentImage = (currentImage + 1) % images.length;
      });
      return true;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compila tutti i campi')),
      );
      return;
    }
    // Simula login
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Stack(
              key: ValueKey(currentImage),
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[currentImage]['path']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    color: Colors.black.withOpacity(0.35),
                    child: Row(
                      children: [
                        Icon(Icons.photo, color: Colors.white.withOpacity(0.8)),
                        const SizedBox(width: 8),
                        Text(
                          images[currentImage]['label']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 8, color: Colors.black)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.45),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 370,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ShowUpAnimation(
                    delay: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.sports_soccer,
                            color: Colors.green, size: 48),
                        const SizedBox(height: 10),
                        TextUtil(
                          text: images[currentImage]['label']!,
                          size: 26,
                          weight: true,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 30),
                        ShowUpAnimation(
                          delay: 400,
                          child: TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.green),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white54),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        ShowUpAnimation(
                          delay: 600,
                          child: TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.green),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white54),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                            ),
                            const Text('Ricordami',
                                style: TextStyle(color: Colors.white)),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text('Password dimenticata?',
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        ShowUpAnimation(
                          delay: 800,
                          child: SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton.icon(
                              onPressed: _login,
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              label: const Text('Accedi',
                                  style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Non hai un account?',
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text('Registrati',
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
