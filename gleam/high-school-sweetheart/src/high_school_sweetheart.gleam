import gleam/string

pub fn first_letter(name: String) {
  string.trim(name)
  |> string.slice(0,1)
}

pub fn initial(name: String) {
  first_letter(name)
  |> string.uppercase
  |> string.append(".")
}

pub fn initials(full_name: String) {
  let last = string.trim_left(full_name)
  |> string.crop(" ")
  |> string.trim_left
  |> initial

  initial(full_name) <> " " <> last
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     "<>initials(full_name1)<>"  +  "<>initials(full_name2)<>"     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
