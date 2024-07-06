import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(err) = problem
  err
}

pub fn remove_team_prefix(team: String) -> String {
  let assert "Team " <> teamname = team
  teamname
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [region, teamname] = string.split(combined, ",Team ")
  #(region, teamname)
}
