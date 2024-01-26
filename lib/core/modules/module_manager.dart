class ModuleManager {
  ModuleManager._internal();

  static final ModuleManager _instance = ModuleManager._internal();

  static ModuleManager get instance => _instance;

  Future<void> init() async {
    await Future.wait([]);
  }

  Future<void> login() async {
    await Future.wait([]);
  }

  Future<void> logout() async {
    await Future.wait([]);
  }
}
