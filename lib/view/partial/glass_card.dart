import 'package:flutter/material.dart';
import 'package:i_dont_remember/enum/palette.dart';
import 'package:shimmer/shimmer.dart';

class GlassCard extends StatefulWidget {
  final double? width, height, shimmerHeight;
  final Widget? child;
  final bool clickable, isShimmer;
  final void Function()? onTap;

  const GlassCard(
      {super.key,
      this.width,
      this.height,
      this.child,
      this.clickable = true,
      this.isShimmer = false,
      this.shimmerHeight,
      this.onTap});

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  final double borderRadiusUp = 16, borderRadiusDown = 10;

  get _borderRadius => _down ? 10.0 : 16.0;

  get _scale => _down ? 0.95 : 1.0;

  get _opacity => _down ? 0.55 : 1.0;

  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => widget.clickable ? setState(() => _down = true) : null,
      onTapUp: (_) => widget.clickable ? setState(() => _down = false) : null,
      onTapCancel: () =>
          widget.clickable ? setState(() => _down = false) : null,
      child: widget.isShimmer
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_borderRadius),
                child: Shimmer(
                  gradient: LinearGradient(
                    begin: const Alignment(1, 1),
                    end: const Alignment(-1, -1),
                    colors: [
                      Palette.card,
                      Palette.card.withOpacity(Palette.card.opacity * 2),
                      Palette.card
                    ],
                    stops: const [0.43, 0.5, 0.57],
                  ),
                  child: Container(
                    width: double.infinity,
                    height: widget.shimmerHeight,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            )
          : AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: Opacity(
                opacity: _opacity,
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: AnimatedContainer(
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 120),
                    decoration: BoxDecoration(
                        color: Palette.card
                            .withOpacity(Palette.card.opacity * _opacity),
                        borderRadius: BorderRadius.circular(_borderRadius)),
                    child: widget.child,
                  ),
                ),
              ),
            ),
    );
  }
}
