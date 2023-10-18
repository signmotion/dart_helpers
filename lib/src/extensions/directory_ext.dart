import 'dart:io' as io show Directory, File, FileSystemEntity;

import 'package:path/path.dart' as p;

extension DirectoryExt on io.Directory {
  List<io.File> allFilesSync({
    bool recursive = false,
    String? extension,
    String? nameContains,
  }) =>
      allFileSystemEntitiesSync<io.File>(
        recursive: recursive,
        extension: extension,
        nameContains: nameContains,
      );

  List<io.Directory> allFoldersSync({
    bool recursive = false,
    String? nameContains,
  }) =>
      allFileSystemEntitiesSync<io.Directory>(
        recursive: recursive,
        nameContains: nameContains,
      );

  List<E> allFileSystemEntitiesSync<E extends io.FileSystemEntity>({
    bool recursive = false,
    String? extension,
    String? nameContains,
  }) =>
      listSync(recursive: recursive)
          .whereType<io.File>()
          .where((entity) => extension == null
              ? true
              : p.extension(entity.path) == '.$extension')
          .where((entity) => nameContains == null
              ? true
              : p.basename(entity.path).contains(nameContains))
          .toList() as List<E>;
}
