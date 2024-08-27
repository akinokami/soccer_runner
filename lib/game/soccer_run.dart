import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import 'soccer.dart';
import '/widgets/hud.dart';
import '/models/settings.dart';
import '/game/audio_manager.dart';
import '/game/enemy_manager.dart';
import '/models/player_data.dart';
import '/widgets/pause_menu.dart';
import '/widgets/game_over_menu.dart';

class SoccerRun extends FlameGame with TapDetector, HasCollisionDetection {
  SoccerRun({super.camera});

  static const _imageAssets = [
    'soccers.webp',
    'barrier/barrier.webp',
    'barrier/barrier_fast.webp',
    'parallax/background.webp',
  ];

  static const _audioAssets = [
    '8-bit-retro.mp3',
    //'8BitPlatformerLoop.wav',
    // 'hurt7.wav',
    // 'jump14.wav',
  ];

  late Soccer _soccer;
  late Settings settings;
  late PlayerData playerData;
  late EnemyManager _enemyManager;

  Vector2 get virtualSize => camera.viewport.virtualSize;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    playerData = await _readPlayerData();
    settings = await _readSettings();

    await AudioManager.instance.init(_audioAssets, settings);

    AudioManager.instance
        .startBgm('8-bit-retro.mp3'); //'8BitPlatformerLoop.wav'

    await images.loadAll(_imageAssets);

    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/background.webp'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );

    camera.backdrop.add(parallaxBackground);
  }

  void startGamePlay() {
    _soccer = Soccer(images.fromCache('soccers.webp'), playerData);
    _enemyManager = EnemyManager();

    world.add(_soccer);
    world.add(_enemyManager);
  }

  void _disconnectActors() {
    _soccer.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  void reset() {
    _disconnectActors();
    playerData.currentScore = 0;
    playerData.lives = 1;
  }

  @override
  void update(double dt) {
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(Hud.id)) {
      _soccer.jump();
    }
    super.onTapDown(info);
  }

  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('SoccerRun.PlayerDataBox');
    final playerData = playerDataBox.get('SoccerRun.PlayerData');

    if (playerData == null) {
      await playerDataBox.put('SoccerRun.PlayerData', PlayerData());
    }

    return playerDataBox.get('SoccerRun.PlayerData')!;
  }

  Future<Settings> _readSettings() async {
    final settingsBox = await Hive.openBox<Settings>('SoccerRun.SettingsBox');
    final settings = settingsBox.get('SoccerRun.Settings');

    if (settings == null) {
      await settingsBox.put(
        'SoccerRun.Settings',
        Settings(bgm: true, sfx: true),
      );
    }
    return settingsBox.get('SoccerRun.Settings')!;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(overlays.isActive(PauseMenu.id)) &&
            !(overlays.isActive(GameOverMenu.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        if (overlays.isActive(Hud.id)) {
          overlays.remove(Hud.id);
          overlays.add(PauseMenu.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
