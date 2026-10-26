import 'package:flutter/material.dart';

import 'hoso.dart';
import 'language_controller.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _rememberLogin = true;

  // Cỡ chữ có thể chọn từ 12 đến 24.
  double _fontSize = 16;

  String _text(String vi, String en) {
    return LanguageController.text(vi, en);
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _darkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF5F6FA);

    final Color cardColor = _darkMode ? const Color(0xFF1E1E1E) : Colors.white;

    final Color textColor = _darkMode ? Colors.white : const Color(0xFF202124);

    final Color subtitleColor = _darkMode
        ? Colors.white70
        : Colors.grey.shade600;

    final Color primaryColor = Colors.blue.shade700;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        // Quy đổi cỡ chữ đã chọn sang hệ số hiển thị.
        textScaler: TextScaler.linear(_fontSize / 16),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _text('Cài đặt', 'Settings'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildProfileHeader(
              cardColor,
              textColor,
              subtitleColor,
              primaryColor,
            ),

            const SizedBox(height: 24),

            _buildSectionTitle(
              _text('Tùy chỉnh giao diện', 'Appearance'),
              textColor,
            ),

            const SizedBox(height: 10),

            _buildSettingCard(
              cardColor: cardColor,
              children: [
                _buildSettingTile(
                  icon: Icons.format_size_rounded,
                  iconColor: Colors.deepPurple,
                  title: _text('Cỡ chữ', 'Font size'),
                  subtitle:
                      '${_text('Kích thước hiện tại', 'Current size')}: ${_fontSize.round()}',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: _showFontSizeDialog,
                ),
                _buildDivider(),
                _buildSettingTile(
                  icon: Icons.language_rounded,
                  iconColor: Colors.blue,
                  title: _text('Ngôn ngữ', 'Language'),
                  subtitle: LanguageController.isVietnamese
                      ? 'Tiếng Việt'
                      : 'English',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: _showLanguageBottomSheet,
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.dark_mode_rounded,
                  iconColor: Colors.indigo,
                  title: _text('Chế độ tối', 'Dark mode'),
                  subtitle: _text(
                    'Sử dụng giao diện tối',
                    'Use dark appearance',
                  ),
                  value: _darkMode,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionTitle(
              _text('Tài khoản và thông báo', 'Account and notifications'),
              textColor,
            ),

            const SizedBox(height: 10),

            _buildSettingCard(
              cardColor: cardColor,
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications_active_rounded,
                  iconColor: Colors.orange,
                  title: _text('Thông báo', 'Notifications'),
                  subtitle: _text(
                    'Bật hoặc tắt thông báo',
                    'Turn notifications on or off',
                  ),
                  value: _notifications,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.lock_rounded,
                  iconColor: Colors.green,
                  title: _text('Ghi nhớ đăng nhập', 'Remember login'),
                  subtitle: _text(
                    'Giữ trạng thái đăng nhập',
                    'Keep your login preference',
                  ),
                  value: _rememberLogin,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onChanged: (value) {
                    setState(() {
                      _rememberLogin = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionTitle(
              _text('Thông tin ứng dụng', 'Application information'),
              textColor,
            ),

            const SizedBox(height: 10),

            _buildSettingCard(
              cardColor: cardColor,
              children: [
                _buildSettingTile(
                  icon: Icons.person_outline_rounded,
                  iconColor: Colors.teal,
                  title: _text('Hồ sơ cá nhân', 'Personal profile'),
                  subtitle: _text(
                    'Xem thông tin cá nhân',
                    'View personal information',
                  ),
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HoSo()),
                    );
                  },
                ),
                _buildDivider(),
                _buildSettingTile(
                  icon: Icons.info_outline_rounded,
                  iconColor: Colors.blueGrey,
                  title: _text('Về ứng dụng', 'About'),
                  subtitle: _text(
                    'Thông tin người phát triển',
                    'Developer information',
                  ),
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: _showAboutDialog,
                ),
              ],
            ),

            const SizedBox(height: 28),

            Center(
              child: Text(
                '© ${DateTime.now().year}',
                style: TextStyle(color: subtitleColor, fontSize: 12),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    Color primaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: primaryColor.withValues(alpha: 0.12),
            child: Icon(Icons.settings_rounded, color: primaryColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _text('Thiết lập ứng dụng', 'App preferences'),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _text(
                    'Tùy chỉnh theo sở thích của bạn',
                    'Customize your experience',
                  ),
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required Color cardColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: iconColor, size: 23),
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(color: subtitleColor, fontSize: 12),
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: subtitleColor),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required Color textColor,
    required Color subtitleColor,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: iconColor, size: 23),
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(color: subtitleColor, fontSize: 12),
        ),
      ),
      trailing: Switch.adaptive(value: value, onChanged: onChanged),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.6,
      indent: 76,
      endIndent: 16,
      color: Colors.grey.withValues(alpha: 0.2),
    );
  }

  // Chọn cỡ chữ từ 12 đến 24.
  void _showFontSizeDialog() {
    double selectedSize = _fontSize;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(_text('Cỡ chữ', 'Font size')),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_text('Kích thước', 'Size')}: '
                      '${selectedSize.round()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Slider(
                      value: selectedSize,
                      min: 12,
                      max: 24,
                      divisions: 12,
                      label: selectedSize.round().toString(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedSize = value;
                        });

                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('12'), Text('24')],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _text('Xem trước cỡ chữ', 'Font size preview'),
                      style: TextStyle(
                        fontSize: selectedSize.clamp(12.0, 24.0).toDouble(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _fontSize = 16;
                    });

                    setDialogState(() {
                      selectedSize = 16;
                    });
                  },
                  child: Text(_text('Mặc định', 'Default')),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(_text('Đóng', 'Close')),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Chọn ngôn ngữ.
  void _showLanguageBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final isVietnamese = LanguageController.isVietnamese;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _text('Chọn ngôn ngữ', 'Choose language'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Text('🇻🇳', style: TextStyle(fontSize: 26)),
                  title: const Text('Tiếng Việt'),
                  trailing: isVietnamese
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    LanguageController.changeLanguage('vi');
                    Navigator.pop(sheetContext);
                  },
                ),
                ListTile(
                  leading: const Text('🇬🇧', style: TextStyle(fontSize: 26)),
                  title: const Text('English'),
                  trailing: !isVietnamese
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    LanguageController.changeLanguage('en');
                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Thông tin ứng dụng.
  void _showAboutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.info_outline_rounded,
            size: 42,
            color: Colors.blue,
          ),
          title: Text(_text('Về ứng dụng', 'About')),
          content: const Text(
            'Nguyễn Quốc Đạt - 23T1080004',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(_text('Đóng', 'Close')),
            ),
          ],
        );
      },
    );
  }
}
