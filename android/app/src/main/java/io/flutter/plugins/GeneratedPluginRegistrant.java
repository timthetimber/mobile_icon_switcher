package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    de.timthetimber.iconswitcher.IconSwitcherPlugin.registerWith(registry.registrarFor("de.timthetimber.iconswitcher.IconSwitcherPlugin"))
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
