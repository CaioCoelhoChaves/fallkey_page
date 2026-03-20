import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class UnderConstructionPage extends StatefulWidget {
  const UnderConstructionPage({super.key});

  @override
  State<UnderConstructionPage> createState() => _UnderConstructionPageState();
}

class _UnderConstructionPageState extends State<UnderConstructionPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    // Background Pulse Animation
    _pulseController = AnimationController(
        duration: const Duration(seconds: 15), vsync: this)
      ..repeat(reverse: true);

    // Floating Logo Animation
    _floatController = AnimationController(
        duration: const Duration(seconds: 3), vsync: this)
      ..repeat(reverse: true);

    // Initialize Particles
    final random = Random();
    for (int i = 0; i < 20; i++) {
      _particles.add(Particle(
        x: random.nextDouble() * 100,
        size: random.nextDouble() * 4 + 1,
        delay: random.nextDouble() * 10,
        duration: random.nextDouble() * 10 + 10,
        controller: AnimationController(
          duration: Duration(milliseconds: ((random.nextDouble() * 10 + 10) * 1000).toInt()),
          vsync: this,
        ),
      ));
      
      // Delay starting the animation
      Future.delayed(Duration(milliseconds: (_particles[i].delay * 1000).toInt()), () {
        if (mounted) {
          _particles[i].controller.repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    for (var p in _particles) {
      p.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 480;

    return Scaffold(
      body: Stack(
        children: [
          // Background Animations
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = 1.0 + (_pulseController.value * 0.1);
                final rotation = _pulseController.value * (5 * pi / 180);
                return Transform.scale(
                  scale: scale,
                  child: Transform.rotate(
                    angle: rotation,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0, 0),
                          radius: 0.6,
                          colors: [
                            Color.fromRGBO(65, 105, 225, 0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0.6, -0.4),
                            radius: 0.5,
                            colors: [
                              Color.fromRGBO(138, 43, 226, 0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Particles
          ..._particles.map((p) {
            return AnimatedBuilder(
              animation: p.controller,
              builder: (context, child) {
                final progress = p.controller.value;
                final opacity = progress < 0.5 ? progress * 2 : (1 - progress) * 2;
                final yPos = size.height - (progress * (size.height + 100));
                
                return Positioned(
                  left: (p.x / 100) * size.width,
                  top: yPos,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: p.size,
                      height: p.size,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          
          // Container Overlay
          Center(
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: isMobile ? size.width * 0.9 : 600,
                      padding: EdgeInsets.all(isMobile ? 40 : 64),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.03),
                        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.05)),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(0, 25),
                            blurRadius: 50,
                            spreadRadius: -12,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Floating Logo
                          AnimatedBuilder(
                            animation: _floatController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -10 * _floatController.value),
                                child: child,
                              );
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: isMobile ? 140 : 180),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(255, 255, 255, 0.05),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/fallkey_logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Title
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFffffff), Color(0xFFA0A0A0)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              "Under Construction",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isMobile ? 32 : 40,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: -0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Text
                          const Text(
                            "We are currently crafting something extraordinary. Our new digital experience will be launching soon. Stay tuned!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFA0A0A0),
                              fontWeight: FontWeight.w300,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Loader
                          const _AnimatedProgressLoader(),
                        ],
                      ),
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

class _AnimatedProgressLoader extends StatefulWidget {
  const _AnimatedProgressLoader();

  @override
  State<_AnimatedProgressLoader> createState() => _AnimatedProgressLoaderState();
}

class _AnimatedProgressLoaderState extends State<_AnimatedProgressLoader> with SingleTickerProviderStateMixin {
  late AnimationController _loaderController;

  @override
  void initState() {
    super.initState();
    _loaderController = AnimationController(
        duration: const Duration(seconds: 3), vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _loaderController,
            builder: (context, child) {
              final value = _loaderController.value;
              double pos;
              if (value <= 0.5) {
                pos = -0.3 + (value * 2) * 1.3;
              } else {
                pos = 1.0 - ((value - 0.5) * 2) * 1.3;
              }
              return Stack(
                children: [
                  Positioned(
                    left: pos * constraints.maxWidth,
                    top: 0,
                    bottom: 0,
                    width: constraints.maxWidth * 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4169e1), Color(0xFF8a2be2)],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class Particle {
  final double x;
  final double size;
  final double delay;
  final double duration;
  final AnimationController controller;

  Particle({
    required this.x,
    required this.size,
    required this.delay,
    required this.duration,
    required this.controller,
  });
}
