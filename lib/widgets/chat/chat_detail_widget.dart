import 'package:flutter/material.dart';
import 'dart:ui'; // 为了使用 ImageFilter

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
    final sendButtonKey = GlobalKey<_SendButtonAnimationState>();
    // 添加文本控制器
    final textController = TextEditingController();
    // 添加焦点控制器
    final focusNode = FocusNode();
    
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
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(39),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(39),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 22.0,
                  sigmaY: 22.0,
                  tileMode: TileMode.decal
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          focusNode: focusNode,
                          maxLines: 2,  // 允许多行输入
                          minLines: 1,     // 最小显示1行
                          textInputAction: TextInputAction.newline,  // 回车键变为换行
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ask me anything...',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8), // 调整垂直内边距
                          ),
                          cursorColor: primaryColor,
                          cursorRadius: const Radius.circular(36),
                          cursorWidth: 2,
                          cursorHeight: 19,
                          onSubmitted: (value) {
                            // 触发发送按钮的动画和操作
                            sendButtonKey.currentState?.triggerSend();
                            // 清空输入内容
                            textController.clear();
                            // 重新获取焦点
                            focusNode.requestFocus();
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 20,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          textController.clear();
                          focusNode.requestFocus();
                        },
                      ),
                      const SizedBox(width: 12),
                      _SendButtonAnimation(
                        key: sendButtonKey,
                        onPressed: () {
                          // TODO: 处理发送消息
                          // 清空输入内容
                          textController.clear();
                          // 保持焦点
                          focusNode.requestFocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
  final GlobalKey<_SendButtonAnimationState> key;

  const _SendButtonAnimation({
    required this.onPressed,
    required this.key,
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

  // 添加触发发送的方法
  void triggerSend() {
    _controller.forward().then((_) {
      _controller.reverse();
      widget.onPressed();
    });
  }
}
