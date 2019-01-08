workflow "New workflow" {
  on = "push"
  resolves = ["AWS S3 Upload"]
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

action "npm run build" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  needs = ["npm test"]
  runs = "npm run build"
}

action "AWS S3 Upload" {
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  needs = ["npm run build"]
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  runs = "aws s3 sync build s3://react-peter-test"
}
