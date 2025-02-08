import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pen.dart';

class Toast {
  static void modal({
    required final String title,
    required final Widget content,
    final List<Widget>? actions,
    final VoidCallback? onSubmit,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          ...actions ?? [],
          if (onSubmit != null)
            TextButton(
              onPressed: onSubmit,
              child: const Text("Save"),
            ),
          TextButton(
            child: const Text("Close"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  static void error({
    required final String title,
    required final String message,
    final String description = "",
    final List<Widget>? actions,
  }) {
    Pen.error("title: $title, message: $message, description: $description");
    Toast.modal(
      title: title,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 48,
        ),
        const SizedBox(height: 10),
        if (title.isNotEmpty && title != "null") ...[
          Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
        ],
        if (description.isNotEmpty && description != "null") ...[
          SizedBox(
              height: 200,
              child: SingleChildScrollView(
                  child: Text(
                description,
                textAlign: TextAlign.left,
              )))
        ]
      ]),
    );
  }

  static void show(final String title, {String? message}) {
    Get.snackbar(
      title,
      message ?? "",
    );
  }

  static Future<void> confirm(
      {required String title,
      required String message,
      VoidCallback? confirm}) async {
    await Get.defaultDialog(
      title: title,
      content: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        child: Text(message),
      ),
      textConfirm: confirm != null ? "Yes" : null,
      textCancel: confirm != null ? "No" : null,
      onConfirm: confirm ??
          () {
            Get.back();
          },
    );
  }

  static Future<void> notify(final String title,
      {final String? outputFile, String message = ""}) async {
    print("Sending notification");
    // TODO: doesn't work anymore
    // final winNotifyPlugin = WindowsNotification(
    //   applicationId: "Cluix"
    //       r"{40dd8e82-c26b-4995-b8a4-1488fad79deb}\WindowsPowerShell\v1.0\powershell.exe",
    // );
    //
    // // create new NotificationMessage instance with id, title, body, and images
    // NotificationMessage notification = NotificationMessage.fromPluginTemplate(
    //   "Command Run Complete", title, message,
    //   // largeImage: file_path,
    //   // image: file_path
    //   // TODO: Figure out how to launch this from app
    //   // launch: "start notepad $outputFile",
    // );

// show notification
//     winNotifyPlugin.showNotificationPluginTemplate(notification);
  }

// TODO: Not needed at the minute
// package: desktop_webview_window
// static openWebUrl(final String url) async {
//   final webView = await WebviewWindow.create();
//   webView.launch(url);
// }
}
