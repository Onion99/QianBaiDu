import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui'; // 为了使用 ImageFilter

import '../../common/theme/colors.dart';

class ChatDetailWidget extends StatefulWidget {
  const ChatDetailWidget({super.key});

  @override
  State<ChatDetailWidget> createState() => _ChatDetailWidgetState();
}

class _ChatDetailWidgetState extends State<ChatDetailWidget> {
  final List<ChatMessage> _messages = [];
  // 添加文本控制器
  final TextEditingController _textController = TextEditingController();
  // 添加滑动控制器
  final ScrollController _scrollController = ScrollController();
  // 添加焦点控制器
  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      /*_messages.insert(0,
          ChatMessage(
            text: text,
            isUser: true,
            timestamp: DateTime.now(),
          ));*/
    });

    _textController.clear();

    // 滚动到列表顶部
    /*_scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );*/
    // 滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    // 模拟AI回复
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "这是一个AI助手的自动回复消息,${Random(100).nextInt(100)}",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    });
    // 再次滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

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
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: false, // 消息从底部开始
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _MessageItem(message: _messages[index]);
                  },
                ),
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

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 功能按钮网格
          /*ConstrainedBox(
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
          ),*/

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
                filter: ImageFilter.blur(sigmaX: 22.0, sigmaY: 22.0, tileMode: TileMode.decal),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
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
                          onSubmitted: _handleSubmitted,
                        ),
                      ),
                      // 使用ValueListenableBuilder监听文本变化
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _textController,
                        builder: (context, value, child) {
                          return AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: AnimatedOpacity(
                              opacity: value.text.isNotEmpty ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              child: SizedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 20,
                                        color: Colors.black45,
                                      ),
                                      onPressed: () {
                                        _textController.clear();
                                        _focusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      _SendButtonAnimation(
                        key: sendButtonKey,
                        onPressed: () => _handleSubmitted(_textController.text),
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

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _MessageItem extends StatelessWidget {
  final ChatMessage message;

  const _MessageItem({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blue[100] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.black87 : Colors.black,
              ),
            ),
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
