import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import '../tools/image/image_tool.dart';
import '../tools/size_tool.dart'; // Ensure these are updated or checked for compatibility

class DeadLine extends SpriteComponent {
  /// Deadline distance from the screen top, in vw units
  static double marginTopVw = 36;

  /// Trigger for showing the deadline, ball distance from the screen top, in vw units
  static double showTopVw = marginTopVw + 44;

  /// Whether to show the deadline
  static bool show = false;

  DeadLine({Sprite sprite, Vector2 size, Vector2 position})
      : super(sprite: sprite, size: size, position: position);

  static DeadLine create(FlameGame game) {
    // Assuming the game size is available and can be used to calculate vw units
    final screenWidth = game.size.x;
    final vwUnit = screenWidth / 100; // 1% of screen width
    final sprite = Sprite(ImageTool.image('dead_line.png'));
    return DeadLine(
      sprite: sprite,
      size: Vector2(screenWidth, vwUnit), // 1vw height
      position: Vector2(0, vwUnit * marginTopVw),
    );
  }

  @override
  void render(Canvas canvas) {
    if (!show) return;
    super.render(canvas);
  }
}
