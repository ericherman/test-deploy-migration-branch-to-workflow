# Testing converting a GitHub repository from branch-based to gh-pages workflow

By default, the deploy-from-branch has two large downsides:

1. Deploy history not visible in a gh-pages branch
2. Workflow steps are fixed, one-size-fits-all

Here we will create a deploy-from-branch repo and convert it to workflow which
updates the gh-pages branch as part of the deploy.

## Migration steps:

### create an orphan branch

It might be possible to do this in the GitHub web interface,
but these are the commandline instructions:

```
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initializing gh-pages branch"
git push origin gh-pages
git checkout main
```

Now we have a branch we can push build and push to.

### set up gh-pages as the deploy branch

1. Go to repository settings, pages
2. find "deploy from branch"
3. Select gh-pages, save

### Add workflow to the repository

This workflow assumes a jekyll build, however your build can be more sophisticated if you change the steps inside the workflow

1. Add [.github/workflows/jekyll-gh-pages.yml](.github/workflows/jekyll-gh-pages.yml)
2. In the `jekyll-gh-pages.yml` file, edit the branch name at `branches: ["release"]` to match the name of the repository's release branch.
3. push and merge
