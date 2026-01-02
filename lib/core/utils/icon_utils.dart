import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum AppIconSize {
  xxl(32), // 32pt
  xl(24), // 24pt
  lg(20), // 20pt
  md(18), // 18pt
  sm(16); // 16pt

  final double size;
  const AppIconSize(this.size);
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final AppIconSize size;
  final Color? color;

  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.xl, // Default to 24pt
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size.size,
      color: color,
    );
  }
}

class IconUtils {
  static const Map<String, IconData> iconMap = {
    // Work & Study
    'briefcase': LucideIcons.briefcase,
    'book-open': LucideIcons.bookOpen,
    'pen-tool': LucideIcons.penTool,
    'monitor': LucideIcons.monitor,
    
    // Health & Life
    'dumbbell': LucideIcons.dumbbell,
    'utensils': LucideIcons.utensils,
    'bed': LucideIcons.bed,
    'coffee': LucideIcons.coffee,
    'sofa': LucideIcons.sofa,
    
    // Leisure
    'gamepad-2': LucideIcons.gamepad2,
    'smartphone': LucideIcons.smartphone,
    'music': LucideIcons.music,
    'tv': LucideIcons.tv,
    'plane': LucideIcons.plane,
    'shopping-bag': LucideIcons.shoppingBag,
    
    // Productivity
    'calendar': LucideIcons.calendar,
    'clock': LucideIcons.clock,
    'list': LucideIcons.list,
    'settings': LucideIcons.settings,
    'plus': LucideIcons.plus,
    'trash-2': LucideIcons.trash2,
    'edit-2': LucideIcons.edit2,
    'grip-vertical': LucideIcons.gripVertical,
    'chevron-left': LucideIcons.chevronLeft,
    'chevron-right': LucideIcons.chevronRight,
  };

  static Widget getIcon(String iconName, {AppIconSize size = AppIconSize.xl, Color? color}) {
    if (iconMap.containsKey(iconName)) {
      return AppIcon(
        iconMap[iconName]!,
        size: size,
        color: color,
      );
    }
    
    // Fallback for legacy emojis
    return Text(
      iconName,
      style: TextStyle(
        fontSize: size.size,
        color: color,
      ),
    );
  }
}
