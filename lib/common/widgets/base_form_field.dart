import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:non_stop/common/mixins/form_validation_mixin.dart';
import 'package:non_stop/core/utils/formatters.dart';

/// 🧩 BaseFormField
/// ------------------------------------------------------------
/// A reusable, customizable text field widget designed to unify
/// the appearance and behavior of input fields across the app.
/// Supports:
///   ✅ Validation via FormValidationMixin
///   ✅ InputFormatters (e.g., digits, email)
///   ✅ Password visibility toggle
///   ✅ Built-in styling + error feedback
/// ------------------------------------------------------------
class BaseFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  const BaseFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.keyboardType,
    this.formatters,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  State<BaseFormField> createState() => _BaseFormFieldState();
}

class _BaseFormFieldState extends State<BaseFormField>
    with FormValidationMixin {
  bool _obscureText = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final labelStyle = theme.textTheme.labelLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: labelStyle?.copyWith(
            color: widget.enabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          enabled: widget.enabled,
          keyboardType:
              widget.keyboardType ??
              (widget.isEmail
                  ? TextInputType.emailAddress
                  : widget.isPhone
                  ? TextInputType.phone
                  : TextInputType.text),
          inputFormatters: widget.formatters ?? _buildDefaultFormatters(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: widget.enabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  )
                : widget.suffixIcon,
            errorText: _errorText,
            filled: true,
            fillColor: widget.enabled
                ? (theme.inputDecorationTheme.fillColor ?? colorScheme.surface)
                : theme.disabledColor.withValues(alpha: 0.1),
          ).applyDefaults(theme.inputDecorationTheme),
          validator: (value) {
            final error = _validateInput(value);
            setState(() => _errorText = error);
            return error;
          },
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  /// اختيار formatters الافتراضية بناءً على نوع الإدخال
  List<TextInputFormatter> _buildDefaultFormatters() {
    if (widget.isEmail) return [Formatters.email];
    if (widget.isPhone) return Formatters.phoneNumber;
    return [];
  }

  /// تحقق ذكي بناءً على نوع الحقل
  String? _validateInput(String? value) {
    final v = widget.validator;
    if (v != null) return v(value);

    if (widget.isEmail && !isEmailValid(value)) {
      return 'Please enter a valid email';
    }
    if (widget.isPassword && !isPasswordStrong(value)) {
      return 'Password must contain uppercase, lowercase, number, and symbol';
    }
    if (widget.isPhone && !isPhoneValid(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
