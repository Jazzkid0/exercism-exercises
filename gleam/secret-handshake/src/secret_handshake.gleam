import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

type CommandMask {
  CommandMask(command: Command, mask: Int)
}

const command_bitmask = [
  CommandMask(Wink, 0b1),
  CommandMask(DoubleBlink, 0b10),
  CommandMask(CloseYourEyes, 0b100),
  CommandMask(Jump, 0b1000),
]

const reverse_bit = 0b10000

pub fn commands(encoded_message: Int) -> List(Command) {
  let cmds = {
    list.filter_map(command_bitmask, fn(cmd) {
      case encoded_message |> int.bitwise_and(cmd.mask) {
        0 -> Error(Nil)
        _ -> Ok(cmd.command)
      }
    })
  }
  case encoded_message |> int.bitwise_and(reverse_bit) {
    0 -> cmds
    _ -> cmds |> list.reverse
  }
}
