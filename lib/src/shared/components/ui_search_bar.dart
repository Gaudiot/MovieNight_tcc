import "dart:async";

import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";

class UISearchBar extends SearchBar {
  final int _delay;
  final double horizontalPadding;
  final double? height;
  final double _elevation;

  final Widget suffixEmptyIcon;
  final Widget suffixIcon;

  final Color? _backgroundColor;

  final TextStyle? _hintStyle;
  final TextStyle? _textStyle;

  const UISearchBar({
    required super.onChanged,
    super.key,
    super.hintText,
    this.horizontalPadding = 16,
    this.height,
    this.suffixEmptyIcon = const Icon(Icons.search),
    this.suffixIcon = const Icon(Icons.close),
    TextStyle? hintStyle,
    TextStyle? textStyle,
    Color? backgroundColor,
    double elevation = 0,
  })  : _delay = 0,
        _backgroundColor = backgroundColor,
        _hintStyle = hintStyle,
        _textStyle = textStyle,
        _elevation = elevation;

  const UISearchBar.delayed({
    required super.onChanged,
    int delayInMs = 500,
    super.hintText,
    super.key,
    this.horizontalPadding = 16,
    this.height,
    this.suffixEmptyIcon = const Icon(Icons.search),
    this.suffixIcon = const Icon(Icons.close),
    TextStyle? hintStyle,
    TextStyle? textStyle,
    Color? backgroundColor,
    double elevation = 0,
  })  : _delay = delayInMs,
        _backgroundColor = backgroundColor,
        _hintStyle = hintStyle,
        _textStyle = textStyle,
        _elevation = elevation;

  @override
  State<UISearchBar> createState() => _UISearchBarState();

  @override
  WidgetStateColor? get backgroundColor {
    if (_backgroundColor == null) return null;
    return WidgetStateColor.resolveWith((_) => _backgroundColor);
  }

  @override
  WidgetStatePropertyAll<EdgeInsetsGeometry?>? get padding {
    return WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: horizontalPadding),
    );
  }

  @override
  BoxConstraints? get constraints {
    if (height == null) return null;
    return BoxConstraints.tightForFinite(height: height!);
  }

  @override
  WidgetStateTextStyle? get textStyle {
    if (_textStyle == null) {
      return WidgetStateTextStyle.resolveWith(
        (_) => AppFonts.robotoTextSmallRegular.copyWith(
          color: AppColors.black,
        ),
      );
    }
    return WidgetStateTextStyle.resolveWith((_) => _textStyle);
  }

  @override
  WidgetStateTextStyle? get hintStyle {
    if (_hintStyle == null) {
      return WidgetStateTextStyle.resolveWith(
        (_) => AppFonts.robotoTextSmallRegular.copyWith(
          color: AppColors.black.withOpacity(0.5),
        ),
      );
    }
    return WidgetStateTextStyle.resolveWith((_) => _hintStyle);
  }

  @override
  WidgetStatePropertyAll<double> get elevation {
    return WidgetStatePropertyAll(_elevation);
  }
}

class _UISearchBarState extends State<UISearchBar> {
  final TextEditingController controller = TextEditingController();
  Timer? timer;
  late Widget suffixIcon;

  @override
  void initState() {
    super.initState();
    setSuffixIcon();
  }

  void setSuffixIcon([String value = ""]) {
    setState(() {
      if (value.isEmpty) {
        suffixIcon = widget.suffixEmptyIcon;
      } else {
        suffixIcon = IconButton(
          icon: widget.suffixIcon,
          onPressed: () {
            controller.clear();
            callback("");
            setSuffixIcon();
          },
        );
      }
    });
  }

  void callback(String value) {
    setSuffixIcon(value);
    if (widget._delay == 0) {
      widget.onChanged!(value);
      return;
    }

    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: widget._delay),
      () {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.onChanged!(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (widget.onChanged != null) ? callback : null,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
        ),
        constraints: widget.constraints,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: widget.textStyle,
    );
  }
}
