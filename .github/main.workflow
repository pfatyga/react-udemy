workflow "New workflow" {
  on = "push"
  resolves = ["npm test"]
}

action "npm install" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  runs = "npm install"
}

action "npm test" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  needs = ["npm install"]
  runs = "npm test"
  env = {
    CI = "true"
  }
}
