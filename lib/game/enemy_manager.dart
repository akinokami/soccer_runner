import 'dart:math';

import 'package:flame/components.dart';

import '/game/enemy.dart';
import 'soccer_run.dart';
import '/models/enemy_data.dart';

class EnemyManager extends Component with HasGameReference<SoccerRun> {
  final List<EnemyData> _data = [];

  final Random _random = Random();

  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      game.virtualSize.x + 32,
      game.virtualSize.y - 24,
    );

    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.size = enemyData.textureSize;
    game.world.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }

    if (_data.isEmpty) {
      _data.addAll([
        EnemyData(
          image: game.images
              .fromCache('barrier/barrier.webp'), //'AngryPig/Walk (36x30).webp'
          nFrames: 16,
          stepTime: 0.10,
          textureSize: Vector2(38, 32),
          speedX: 80,
          canFly: false,
        ),
        EnemyData(
          image: game.images.fromCache('barrier/barrier_fast.webp'),
          nFrames: 7,
          stepTime: 0.1,
          textureSize: Vector2(38, 32),
          speedX: 100,
          canFly: false,
        ),
        // EnemyData(
        //   image: game.images.fromCache('Rino/Run (52x34).webp'),
        //   nFrames: 6,
        //   stepTime: 0.09,
        //   textureSize: Vector2(52, 34),
        //   speedX: 150,
        //   canFly: false,
        // ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
