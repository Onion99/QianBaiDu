import 'package:flutter/material.dart';
import 'dart:ui';

import '../common/theme/colors.dart';


class ChatResultsWidget extends StatelessWidget {
  const ChatResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Container(
      foregroundDecoration: null,
      /*decoration: BoxDecoration(color: secondaryColor),*/
      decoration: BoxDecoration(
        /*gradient: LinearGradient(
            begin: Alignment(-0.4, -1.0),
            end: Alignment(1.0, 0.6),
            colors: [
              secondaryColor,
              primaryColor,
              secondaryColor
            ],
            stops: [
              0.3,
              0.7,
              1.0
            ]
        ),*/
        borderRadius: BorderRadius.all(Radius.zero),
        gradient: LinearGradient(
            begin: Alignment(-0.7, -1.0),
            end: Alignment.bottomCenter,
            colors: [
              secondaryColor,
              primaryGradientColor,
              secondaryColor,
              secondaryColor
            ],
            stops: [
              0.4,
              0.5,
              0.7,
              1.0
            ]
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: _buildBottomBar(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildGlassCard(
              child: _buildImageGenerationContent(),
            ),
            const SizedBox(height: 12),
            _buildGlassCard(
              child: _buildParrotImagesContent(),
            ),
            const SizedBox(height: 12),
            _buildGlassCard(
              child: _buildAISearchContent(),
            ),
            const SizedBox(height: 12),
            _buildGlassCard(
              child: _buildCAQuestionContent(),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.7),
                Colors.white.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildImageGenerationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15,
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Text(
                'Image Generation',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.open_in_full, size: 20),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Today • 14:20',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Positioned(
              right: 8,
              top: 8,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '+2',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildParrotImagesContent() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.photo_library, size: 20),
          SizedBox(width: 8),
          Text('Parrot images'),
          Spacer(),
          Text('+3'),
        ],
      ),
    );
  }

  Widget _buildAISearchContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20),
          const SizedBox(width: 8),
          const Text('AI Search'),
          const Spacer(),
          Text(
            'Yesterday • 15 Oct',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildCAQuestionContent() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.help_outline, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'How to decrease CA?',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGlassIcon(Icons.add),
          _buildSelectButton(),
          _buildGlassIcon(Icons.star_border),
          _buildGlassIcon(Icons.home_outlined),
        ],
      ),
    );
  }


  final double iconSize = 54;

  Widget _buildGlassIcon(IconData icon) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(iconSize/2),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildSelectButton() {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: selectColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(iconSize/2),
        border: Border.all(
          color: selectColor.withOpacity(0.9),
        ),
      ),
      child: const Icon(Icons.play_arrow, color: Colors.white,size: 20),
    );
  }
}
