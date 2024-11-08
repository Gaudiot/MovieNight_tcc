import "package:flutter/widgets.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";

class PageIndicator extends StatefulWidget {
  final int itemCount;
  final int currentIndex;

  const PageIndicator({
    required this.itemCount,
    required this.currentIndex,
    super.key,
  });

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width:
                widget.currentIndex == index ? 20 : 10, // Tamanho do indicador
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: ShapeDecoration(
              color: widget.currentIndex == index
                  ? AppColors.white
                  : AppColors.gray,
              shape: const StadiumBorder(),
            ),
          );
        },
      ),
    );
  }
}
