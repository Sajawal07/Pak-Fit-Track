import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'sync_queue_item.g.dart';

enum SyncEntity { food, weight, activity }
enum SyncAction { create, update, delete }

@Collection()
class SyncQueueItem {
  Id? id; // auto‑generated primary key

  @Enumerated(EnumType.name)
  late SyncEntity entity;
  late int localId; // Isar Id of the affected record
  @Enumerated(EnumType.name)
  late SyncAction action;
  String? operationId; // nullable for codegen compatibility

  late DateTime queuedAt;
  int retryCount = 0;
  String? lastError;
  // Optional device identifier for debugging multi‑device scenarios
  String? deviceId;

  SyncQueueItem({
    required this.entity,
    required this.localId,
    required this.action,
    String? operationId,
    this.deviceId,
  }) : operationId = operationId ?? const Uuid().v4(),
       queuedAt = DateTime.now();
}
