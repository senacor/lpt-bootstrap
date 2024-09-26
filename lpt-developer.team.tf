resource "github_team" "lpt_developers" {
  name        = "LPT Developer Team"
  description = "Team developing the load and performance test example projects"

  create_default_maintainer = true
}

resource "github_team_members" "lpt_developers_members" {
  team_id = github_team.lpt_developers.id

  members {
    username = data.github_membership.psi.username
    role     = "maintainer"
  }

  members {
    username = data.github_membership.frudisch.username
    role     = "maintainer"
  }
}