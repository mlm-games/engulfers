class_name Util

static var game_root = Engine.get_main_loop().root

static func get_enum_key_as_string(key: C.Groups) -> StringName:
  return C.Groups.keys()[key].capitalize()
