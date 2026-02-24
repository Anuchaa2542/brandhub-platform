// core/widgets/app_text_field.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum DynamicTextFieldMode {
  textField,
  textArea,
  datePicker,
  yearPicker,
  monthPicker,
  searchField,
  dropdown,
}

class DynamicTextField extends StatelessWidget {
  final DynamicTextFieldMode mode;
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool show;
  final bool readOnly;
  final bool disabled;
  final bool required;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? disabledColor;
  final String? unitText;
  final bool showUnitInside;
  final bool blockEmoji;
  final bool blockSpecialChar;
  final bool onlyThaiEnglish;
  final bool blockInvisibleJunk;
  final bool trimLeadingSpace;
  final bool enforceMaxLength;
  final bool enableAdvancedInputControl;
  final BuildContext? contextForPicker;
  final Rx<DateTime>? currentDate;
  final TextEditingController? indexMonthController;
  final Function()? onClearPressed;
  final bool showTooltip;
  final String tooltipMessage;
  final Color? tooltipColor;
  final bool obscureText;
  final bool showCounter; // ควบคุมการแสดง counter (default false = ไม่แสดงเลย)

  const DynamicTextField({
    super.key,
    required this.mode,
    required this.label,
    required this.hintText,
    this.controller,
    this.show = true,
    this.readOnly = false,
    this.disabled = false,
    this.required = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onTapOutside,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.height,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.disabledColor,
    this.unitText,
    this.showUnitInside = false,
    this.blockEmoji = false,
    this.blockSpecialChar = false,
    this.onlyThaiEnglish = false,
    this.blockInvisibleJunk = false,
    this.trimLeadingSpace = false,
    this.enforceMaxLength = false,
    this.enableAdvancedInputControl = false,
    this.contextForPicker,
    this.currentDate,
    this.indexMonthController,
    this.onClearPressed,
    this.showTooltip = false,
    this.tooltipMessage = '',
    this.tooltipColor,
    this.obscureText = false,
    this.showCounter = false, // default ไม่แสดง counter
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    final effectiveController = controller ?? TextEditingController();
    final effectiveMaxLength = maxLength ?? 999999;
    final currentLength = 0.obs;

    int codePointLength(String s) => s.runes.length;

    void updateLength() {
      final text = effectiveController.text;
      final length = codePointLength(text);
      currentLength.value = length;
      if (length > effectiveMaxLength && enforceMaxLength) {
        final trimmedRunes = text.runes.take(effectiveMaxLength).toList();
        final trimmedText = String.fromCharCodes(trimmedRunes);
        effectiveController.value = TextEditingValue(
          text: trimmedText,
          selection: TextSelection.collapsed(offset: trimmedText.runes.length),
        );
      }
    }

    effectiveController.addListener(updateLength);

    final List<TextInputFormatter> formatters = [];
    if (enableAdvancedInputControl) {
      if (blockEmoji) {
        formatters.add(
          FilteringTextInputFormatter.deny(
            RegExp(
              r'[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
              unicode: true,
            ),
          ),
        );
      }
      if (blockSpecialChar || trimLeadingSpace) {
        formatters.add(
          _SpecialCharAndTrimFormatter(
            blockSpecial: blockSpecialChar,
            trimLeading: trimLeadingSpace,
          ),
        );
      }
      if (onlyThaiEnglish) {
        formatters.add(
          FilteringTextInputFormatter.allow(RegExp(r'^[ก-๙เ-์a-zA-Z\s]*$')),
        );
      }
      if (blockInvisibleJunk) {
        formatters.add(
          FilteringTextInputFormatter.deny(RegExp(r'[\u200B-\u200D\uFEFF]')),
        );
      }
    }
    if (enforceMaxLength) {
      formatters.add(LengthLimitingTextInputFormatter(effectiveMaxLength));
    }

    final bool isMultiLine = mode == DynamicTextFieldMode.textArea;
    final effectiveMaxLines = isMultiLine ? (maxLines) : 1;
    final effectiveMinLines = isMultiLine ? (minLines ?? 3) : 1;

    final effectiveFontSize = fontSize ?? AppSizes.input;
    final effectiveContentPadding = EdgeInsets.symmetric(
      horizontal: AppSizes.md,
      vertical: AppSizes.sm,
    );
    final effectiveBorderRadius = AppRadius.allMd;
    final effectiveHeight = height ?? AppSizes.inputHeight;

    Widget? effectiveSuffixIcon = suffixIcon;
    if (showUnitInside && unitText != null && unitText!.isNotEmpty) {
      effectiveSuffixIcon = Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          unitText!,
          style: GoogleFonts.inter(
            fontSize: AppSizes.bodyMd,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else if (mode == DynamicTextFieldMode.datePicker) {
      effectiveSuffixIcon = Icon(Icons.calendar_today, size: AppSizes.iconMd);
    } else if (mode == DynamicTextFieldMode.yearPicker) {
      effectiveSuffixIcon = Icon(
        Icons.calendar_view_month,
        size: AppSizes.iconMd,
      );
    } else if (mode == DynamicTextFieldMode.monthPicker) {
      effectiveSuffixIcon = Icon(
        Icons.calendar_view_week,
        size: AppSizes.iconMd,
      );
    } else if (mode == DynamicTextFieldMode.dropdown ||
        mode == DynamicTextFieldMode.searchField) {
      effectiveSuffixIcon = Icon(
        Icons.arrow_forward_ios,
        size: AppSizes.iconSm,
      );
    }

    VoidCallback? effectiveOnTap;
    if (mode == DynamicTextFieldMode.datePicker ||
        mode == DynamicTextFieldMode.yearPicker ||
        mode == DynamicTextFieldMode.monthPicker ||
        mode == DynamicTextFieldMode.dropdown) {
      effectiveOnTap = () async {
        if (disabled || readOnly) return;
        if (onTap != null) {
          onTap!();
          return;
        }
        if (mode == DynamicTextFieldMode.datePicker &&
            contextForPicker != null) {
          final picked = await showDatePicker(
            context: contextForPicker!,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            effectiveController.text = picked.toIso8601String().split('T')[0];
          }
        }
      };
    }

    Widget labelWidget = Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: AppSizes.bodyLg,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        if (required) const Text(' *', style: TextStyle(color: Colors.red)),
        if (showTooltip)
          Tooltip(
            message: tooltipMessage,
            child: Padding(
              padding: EdgeInsets.only(left: AppSizes.xs),
              child: Icon(
                Icons.info_outline,
                size: AppSizes.iconSm,
                color: tooltipColor ?? Colors.blue,
              ),
            ),
          ),
      ],
    );

    InputDecoration decoration = InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
      suffixIcon: effectiveSuffixIcon,
      fillColor: disabled
          ? (disabledColor ?? AppColors.surface)
          : (fillColor ?? AppColors.surface),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: BorderSide(color: borderColor ?? AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: BorderSide(color: borderColor ?? AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: effectiveContentPadding,
    );

    if (mode == DynamicTextFieldMode.searchField) {
      decoration = decoration.copyWith(
        suffixIcon: Obx(
          () => effectiveController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, size: AppSizes.iconMd),
                  onPressed: () {
                    effectiveController.clear();
                    onClearPressed?.call();
                  },
                )
              : (effectiveSuffixIcon ?? const SizedBox.shrink()),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[labelWidget, SizedBox(height: AppSizes.xs)],
        SizedBox(
          height: effectiveHeight,
          child: TextFormField(
            controller: effectiveController,
            readOnly: readOnly || disabled,
            enabled: !disabled,
            onTap: effectiveOnTap,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onTapOutside: onTapOutside,
            validator: validator,
            keyboardType: keyboardType,
            maxLength: effectiveMaxLength,
            maxLines: effectiveMaxLines,
            minLines: effectiveMinLines,
            inputFormatters: formatters,
            textAlign: textAlign,
            obscureText: obscureText,
            style: GoogleFonts.inter(
              fontSize: effectiveFontSize,
              fontWeight: fontWeight,
              color: disabled ? AppColors.textSecondary : AppColors.textPrimary,
            ),
            // ซ่อน counter ของ Flutter เองโดยสมบูรณ์
            buildCounter: showCounter
                ? null // ถ้าเปิด showCounter ให้ Flutter แสดงเอง (กรณีนี้จะไม่ใช้)
                : (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => const SizedBox.shrink(),
            decoration: decoration,
          ),
        ),
        // แสดง counter แบบ custom เฉพาะเมื่อ showCounter = true และเป็น textArea
        if (showCounter && isMultiLine) ...[
          SizedBox(height: AppSizes.xs),
          Obx(
            () => Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$currentLength/$effectiveMaxLength',
                style: AppTextStyles.caption,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SpecialCharAndTrimFormatter extends TextInputFormatter {
  final bool blockSpecial;
  final bool trimLeading;

  _SpecialCharAndTrimFormatter({
    required this.blockSpecial,
    required this.trimLeading,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (trimLeading) {
      text = text.trimLeft();
    }

    if (blockSpecial) {
      text = text.replaceAll(RegExp(r'[^ก-๙เ-์a-zA-Z0-9\s]'), '');
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
