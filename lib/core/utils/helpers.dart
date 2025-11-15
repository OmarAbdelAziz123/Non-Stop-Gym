import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// 🌟 helpers.dart
/// ------------------------------------------------------------
/// A utility class that provides commonly used helper functions
/// for formatting, sharing, file handling, time conversion,
/// and more — ideal for short-video or social apps like TikTok.
/// ------------------------------------------------------------
class Helpers {
  // 🛡️ Private constructor to prevent instantiation
  Helpers._();

  // 📅 ---------------------- DATE & TIME ----------------------

  /// 🔹 Manual "time ago" without Jiffy (النتيجة عربية)
  static String timeAgoManual(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return '${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return '${diff.inHours} ساعة';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 7) return '${diff.inDays} يوم';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} أسبوع';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} شهر';
    return '${(diff.inDays / 365).floor()} سنة';
  }

  /// 🔸 تنسيق التاريخ كـ `dd/MM/yyyy` بالإنجليزي
  static String formatDate(DateTime dateTime) {
    Jiffy.setLocale('en');
    return Jiffy.parseFromDateTime(dateTime).format(pattern: 'dd/MM/yyyy');
  }

  /// 🔸 تنسيق الوقت كـ `HH:mm` (24 ساعة) بالإنجليزي
  static String formatTime(DateTime dateTime) {
    Jiffy.setLocale('en');
    return Jiffy.parseFromDateTime(dateTime).format(pattern: 'HH:mm');
  }

  /// 🔹 Using Jiffy for "time ago" بالإنجليزي
  static String timeAgoJiffy(DateTime dateTime) {
    Jiffy.setLocale('en');
    return Jiffy.parseFromDateTime(dateTime).fromNow();
  }

  /// 🔸 تنسيق التاريخ باستخدام نمط مخصص بالإنجليزي
  static String formatCustom(DateTime dateTime, String pattern) {
    Jiffy.setLocale('en');
    return Jiffy.parseFromDateTime(dateTime).format(pattern: pattern);
  }

  // 🔢 ---------------------- NUMBERS --------------------------

  /// 🔸 Shortens large numbers (e.g., 1200 → 1.2K, 2,300,000 → 2.3M)
  static String formatCount(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  /// 🔸 Formats number with commas (e.g., 15000 → 15,000)
  static String formatWithCommas(num number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  // 💾 ---------------------- FILES ----------------------------

  /// 🔸 Saves a file from [Uint8List] bytes (e.g., image/video) to local storage
  static Future<File> saveFile(Uint8List bytes, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// 🔸 Checks if a file exists safely
  static Future<bool> fileExists(String path) async {
    return File(path).exists();
  }

  /// 🔸 Deletes file if it exists
  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) await file.delete();
  }

  // 📱 ---------------------- UI HELPERS -----------------------

  /// 🔸 Shows a simple SnackBar message
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// 🔸 Copies text to clipboard with confirmation
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    showSnackBar(context, 'تم النسخ إلى الحافظة');
  }

  /// 🔸 Opens a URL safely (e.g., TikTok profile, external links)
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('❌ Could not launch $url');
    }
  }

  // 📤 ---------------------- SHARING --------------------------

  /// 🔸 Shares text or links using system share sheet
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }

  /// 🔸 Shares file (e.g., downloaded video or image)
  static Future<void> shareFile(File file, {String? text}) async {
    await Share.shareXFiles([XFile(file.path)], text: text);
  }

  // 🧮 ---------------------- MEDIA HELPERS --------------------

  /// 🔸 Converts bytes to human readable format (e.g., "12.4 MB")
  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes == 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor(); // ✅ استخدم log من dart:math
    final size = bytes / pow(1024, i);
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  /// 🔸 Extracts file extension (e.g., .mp4, .jpg)
  static String getFileExtension(String path) =>
      path.split('.').last.toLowerCase();

  // ⏳ ---------------------- MISC HELPERS ---------------------

  /// 🔸 Waits for [milliseconds] (useful for delaying animations or loaders)
  static Future<void> delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// 🔸 Checks if string is a valid URL
  static bool isValidUrl(String url) {
    final pattern = r'^(https?:\/\/)?([\w\d-]+\.){1,2}[a-zA-Z]{2,}(\/\S*)?$';
    return RegExp(pattern).hasMatch(url);
  }

  /// 🔸 Capitalizes the first letter of a sentence
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// 🔸 Removes extra spaces and trims input
  static String cleanText(String text) =>
      text.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// 🔸 Generates a unique timestamp-based ID (for videos, posts, etc.)
  static String generateUniqueId() =>
      DateTime.now().millisecondsSinceEpoch.toString();
}
