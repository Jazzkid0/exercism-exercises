import gleam/string

pub fn message(log_line: String) -> String {
  string.crop(log_line, ": ")
    |> string.drop_left(1)
    |> string.trim
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[ERROR" <> _t -> "error"
    "[INFO" <> _t -> "info"
    "[WARNING" <> _t -> "warning"
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  case log_line {
    "[ERROR]: " <> t -> string.trim(t) <> " (error)"
    "[INFO]: " <> t -> string.trim(t) <> " (info)"
    "[WARNING]: " <> t -> string.trim(t) <> " (warning)"
    _ -> ""
  }
}
