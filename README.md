# nebula-chain
This project contains scripts that help release process for gradle projects.  This script needs `bash` command.

## release.sh
### Prerequisites

- Install [`gh`](https://github.com/cli/cli#installation) command, then run `gh auth login` to authenticate for the first time.
- Install [`gren`](https://www.npmjs.com/package/gren-release-notes) command, then set environment variable of `GREN_GITHUB_TOKEN`.
- Change `Git clone depth` in AWS CodeBuild to `Full` if you build on AWS CodeBuild.
- Update build.gradle in your project.
  - Add rebula.release plugin to plugins in build.gradle (e.g. `id 'nebula.release' version '15.3.0'`).
  - Add task dependency if necessary. (e.g. `tasks.release.dependsOn ":dipper-common-core:publish", ":dipper-common-pdf:publish"`)
- Change current branch to master (or main)

### What to do
- Bump up the minor version, then publish it.  If you want to change major or patch version, add the following parameter.
  - `release.sh -Prelease.scope=major`
  - `release.sh -Prelease.scope=patch`
- Create a new release version, then write the history from the previous release version.

## Why nebula-chain?
Because this repository connects each task of release process like a chain with [nebula](https://github.com/nebula-plugins/nebula-release-plugin) plugin.
