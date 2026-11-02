
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/task_model.dart';

class FirebaseService {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final analytics = FirebaseAnalytics.instance;
  static final remoteConfig = FirebaseRemoteConfig.instance;

  static String get uid {
    final user = auth.currentUser;
    if (user == null) {
      throw StateError('Bạn chưa đăng nhập');
    }
    return user.uid;
  }

  static CollectionReference<Map<String, dynamic>>
      get taskCollection {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('tasks');
  }

  // ============================
  // CLOUD FIRESTORE
  // ============================

  static Stream<List<TaskModel>> getTasks() {
    return taskCollection
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(TaskModel.fromFirestore)
          .toList();
    });
  }

  static Future<void> addTask({
    required String title,
    required String category,
    required String time,
  }) async {
    await taskCollection.add({
      'title': title,
      'category': category,
      'time': time,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await logEvent('task_created');
  }

  static Future<void> updateTask(
    String id, {
    required String title,
    required String category,
    required String time,
  }) async {
    await taskCollection.doc(id).update({
      'title': title,
      'category': category,
      'time': time,
    });

    await logEvent('task_updated');
  }

  static Future<void> toggleTask(
    String id,
    bool completed,
  ) async {
    await taskCollection.doc(id).update({
      'completed': completed,
    });

    await logEvent(
      completed ? 'task_completed' : 'task_uncompleted',
    );
  }

  static Future<void> deleteTask(String id) async {
    await taskCollection.doc(id).delete();
    await logEvent('task_deleted');
  }

  // ============================
  // FIREBASE STORAGE
  // ============================

  static Future<String> uploadAvatar(
    String filePath,
  ) async {
    if (kIsWeb) {
      throw UnsupportedError(
        'Ví dụ upload này dành cho Android/iOS.',
      );
    }

    final ref = FirebaseStorage.instance
        .ref()
        .child('avatars')
        .child('$uid.jpg');

    await ref.putFile(
      File(filePath),
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final url = await ref.getDownloadURL();

    await auth.currentUser!.updatePhotoURL(url);

    await firestore
        .collection('users')
        .doc(uid)
        .set({
      'photoUrl': url,
    }, SetOptions(merge: true));

    await logEvent('avatar_uploaded');

    return url;
  }

  // ============================
  // FIREBASE ANALYTICS
  // ============================

  static Future<void> logEvent(String name) async {
    try {
      if (!kIsWeb &&
          (defaultTargetPlatform ==
                  TargetPlatform.android ||
              defaultTargetPlatform ==
                  TargetPlatform.iOS)) {
        await analytics.logEvent(name: name);
      }
    } catch (e) {
      debugPrint('Analytics: $e');
    }
  }

  // ============================
  // REMOTE CONFIG
  // ============================

  static Future<String> getWelcomeMessage() async {
    try {
      await remoteConfig.setDefaults({
        'welcome_message':
            'Đã hơn nửa chặng, cố lên!',
      });

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval:
              const Duration(minutes: 5),
        ),
      );

      await remoteConfig.fetchAndActivate();

      return remoteConfig.getString(
        'welcome_message',
      );
    } catch (e) {
      debugPrint('Remote Config: $e');
      return 'Đã hơn nửa chặng, cố lên!';
    }
  }

  // ============================
  // CLOUD MESSAGING
  // ============================

  static Future<void> setupMessaging() async {
    if (kIsWeb ||
        defaultTargetPlatform !=
            TargetPlatform.android) {
      return;
    }

    try {
      final messaging = FirebaseMessaging.instance;

      await messaging.requestPermission();

      final token = await messaging.getToken();

      if (token != null) {
        await firestore
            .collection('users')
            .doc(uid)
            .set({
          'fcmToken': token,
        }, SetOptions(merge: true));
      }

      FirebaseMessaging.onMessage.listen((message) {
        debugPrint(
          'FCM: ${message.notification?.title}',
        );
      });
    } catch (e) {
      debugPrint('Messaging: $e');
    }
  }

  // ============================
  // CRASHLYTICS
  // ============================

  static Future<void> recordError(
    Object error,
    StackTrace stack,
  ) async {
    if (kIsWeb ||
        (defaultTargetPlatform !=
                TargetPlatform.android &&
            defaultTargetPlatform !=
                TargetPlatform.iOS)) {
      return;
    }

    await FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: false,
    );
  }
}
