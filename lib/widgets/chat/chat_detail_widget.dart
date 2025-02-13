import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';

class ChatDetailWidget extends StatelessWidget {
  const ChatDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部聊天头部
            _buildChatHeader(),

            // 聊天内容区域将占用剩余空间
            Expanded(
              child: Container(
                color: Colors.grey[50],
                // TODO: 这里添加聊天消息列表
              ),
            ),

            // 底部功能区
            _buildBottomFeatures(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 返回按钮
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          const Text(
            'New Chat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          // 关闭按钮
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomFeatures() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 功能按钮网格
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200), // 限制最大高度
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5, // 调整按钮的宽高比
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildFeatureButton(
                  icon: Icons.translate,
                  label: 'Translate',
                  color: Colors.blue[100]!,
                ),
                _buildFeatureButton(
                  icon: Icons.mic,
                  label: 'Audio Chat',
                  color: Colors.green[100]!,
                ),
                _buildFeatureButton(
                  icon: Icons.file_present,
                  label: 'Chat Files',
                  color: Colors.orange[100]!,
                ),
                _buildFeatureButton(
                  icon: Icons.image,
                  label: 'Images',
                  color: Colors.purple[100]!,
                ),
              ],
            ),
          ),

          // 底部输入框
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(39),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ask me anything...',
                    ),
                  ),
                ),
                _SendButtonAnimation(
                  onPressed: () {
                    // TODO: 处理发送消息
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28), // 稍微减小图标大小
          const SizedBox(height: 4), // 减小间距
          Text(
            label,
            style: const TextStyle(fontSize: 13), // 调整文字大小
          ),
        ],
      ),
    );
  }
}

class _SendButtonAnimation extends StatefulWidget {
  final VoidCallback onPressed;

  const _SendButtonAnimation({
    required this.onPressed,
  });

  @override
  State<_SendButtonAnimation> createState() => _SendButtonAnimationState();
}

class _SendButtonAnimationState extends State<_SendButtonAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.1,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_upward,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
