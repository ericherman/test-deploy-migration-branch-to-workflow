# Converting a GitHub repository from default deployment to gh-pages deployment

By default, the automatic deploy-from-branch has three notable downsides:

1. Deploy history not visible in a gh-pages branch.
2. Workflow steps are fixed, one-size-fits-all.
3. Difficult to use as a sub-project, as the build needs to be replicated.

This repository was created as an automatic deployment repository and then converted to a workflow-based deployment.

With the conversion, the workflow updates the gh-pages branch as part of the release, and the site is deployed from that branch.

Below you can read steps which can be used to accomplish this.

## Migration steps:

### Create an orphan branch

It might be possible to do this in the GitHub web interface,
but these are the command-line instructions:

```
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initializing gh-pages branch"
git push origin gh-pages
git checkout main
```

At this point there is a branch that builds can be pushed to.

### Set up gh-pages as the deploy branch

1. Go to repository settings, pages
2. find "deploy from branch"
3. Select gh-pages, save

### Add workflow to the repository

This workflow assumes a jekyll build, however your build can be more sophisticated if you change the steps inside the workflow.

1. Add [.github/workflows/release-gh-pages.yml](.github/workflows/release-gh-pages.yml)
2. In the `release-gh-pages.yml` file, edit the branch name at `branches: ["release"]` to match the name of the repository's release branch.
3. push and merge

## Conclusion

### Branches

branch name | process notes
-----|-----
main | The `main` branch is where active development happens. Most pull requests are opened against this branch.
release | To create a release, open and merge a pull request from `main` to `release`. The workflow defined in `release-gh-pages.yml` will be launched by the merge.
gh-pages | The workflow launched by the merge will generate the HTML, CSS, JavaScript and other assets from the `release` branch. After building, the workflow will push the results to the `gh-pages` branch.  Github automatically deploys the contents of the `gh-pages` branch to [github.io](https://ericherman.github.io/test-deploy-migration-branch-to-workflow/).

### Downsides

* From time-to-time someone may need to update the GitHub workflow file, and thus need to learn about [GitHub Workflows](https://docs.github.com/en/actions/using-workflows).
* Builds have been observed to take a few minutes to "go live".

### Advantages

* If desired, the build process can be extended and made more sophisticated.
* The history of the _results_ of the releases can be reviewed with git.
* If used as a sub-project, the super-project can use the `gh-pages` branch, thus being "tool agnostic" about whatever build process the sub-project chooses.
