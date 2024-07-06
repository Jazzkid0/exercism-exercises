import simplifile
import gleam/string
import gleam/result
import gleam/list

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(contents) -> Ok(string.trim_right(contents) |> string.split("\n"))
    _ -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  simplifile.create_file(path) |> result.nil_error()
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(path, email <> "\n") |> result.nil_error()
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case create_log_file(log_path) {
    Ok(_) -> {
      use emails <- result.try(read_emails(emails_path))
      use email <- list.try_each(emails)
      case send_email(email) |> result.nil_error() {
        Ok(Nil) -> log_sent_email(log_path, email)
        _ -> Ok(Nil)
      }}
    _ -> Error(Nil)
  }
}
