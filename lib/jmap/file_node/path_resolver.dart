import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/file_node/file_node.dart';

class FileNodePathResolver {
  final List<FileNode> nodes;

  FileNodePathResolver(this.nodes);

  /// Returns the FileNode or null if path not found.
  FileNode? resolve(String path) {
    if (path.isEmpty || path == "/") {
      return null; // root
    }

    // "/a/b/" → ["a", "b"]
    final parts = path
        .split("/")
        .where((p) => p.trim().isNotEmpty)
        .toList();

    FileNode? current;
    String? currentParentId; // root level

    for (final part in parts) {
      FileNode? next;

      // Find a node whose name matches AND whose parentId matches the current folder
      for (final n in nodes) {
        final isChildOfCurrent =
            (n.parentId == null && currentParentId == null) ||
            (n.parentId?.value == currentParentId);

        if (n.name == part && isChildOfCurrent) {
          next = n;
          break;
        }
      }

      if (next == null) {
        return null; // path not found
      }

      current = next;
      currentParentId = next.id?.value;
    }

    return current;
  }

  /// List direct children of the given parentId.
  /// parentIdValue = null, root
  List<FileNode> listChildren(String? parentIdValue) {
    return nodes.where((node) {
      final pid = node.parentId?.value;
      return pid == parentIdValue || (pid == null && parentIdValue == null);
    }).toList();
  }
}

class ResolvedPath {
  final String fileName;
  final Id? parentId;
  ResolvedPath(this.fileName, this.parentId);
}
