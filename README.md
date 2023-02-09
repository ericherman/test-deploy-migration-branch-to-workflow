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

1. Add [.github/workflows/jekyll-gh-pages.yml](.github/workflows/jekyll-gh-pages.yml)
2. In the `jekyll-gh-pages.yml` file, edit the branch name at `branches: ["release"]` to match the name of the repository's release branch.
3. push and merge

## Conclusion

### Process

In this repository, the `main` branch is were active development happens.
To create a release, a pull request from `main` to `release` will be merged.
The workflow defined in `jekyll-gh-pages.yml` will be launched by the merge.
The workflow will build the site and push the results to the `gh-pages` branch.
Github then deploys the results to the `github.io`.

### Downsides

* From time-to-time someone may need to update the GitHub workflow file, and thus need to learn about [GitHub Workflows](https://docs.github.com/en/actions/using-workflows).
* Builds have been observed to take a few minutes to "go live".

### Advantages

* If desired, the build process can be extended and made more sophisticated.
* The history of the _results_ of the releases can be reviewed with git.
* If used as a sub-project, the super-project can use the `gh-pages` branch, thus being "tool agnostic" about whatever build process the sub-project chooses.
