# Testing converting a GitHub repository from branch-based to gh-pages workflow

By default, the deploy-from-branch has two large downsides:

1. Deploy history not visible in a gh-pages branch
2. Workflow steps are fixed, one-size-fits-all

Here we will create a deploy-from-branch repo and convert it to workflow which
updates the gh-pages branch as part of the deploy.

## Migration steps:

### Phase 1: create a workflow

1. Go to repository settings, pages
2. Change "deploy from branch" to "GitHub Actions"
3. Select "Configure" on the "Jekyll theme" option
4. Adjust branch name from "main" if that is not the release branch
5. Press big green "Start Commit" button.
6. Add comments, and select "Create a new branch" and a branch name
7. Click propose new file
8. "Create pull request"
9. "Merge", "Confirm merge"
10. go to "Pull requests"
11. new PR from the development branch to the release branch
12. Click "Create pull request"
13. "Merge", "Confirm merge"

Now we have a generic workflow which we will edit.

### Phase 2: create an orphan branch

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

### Phase 3

1. Go to repository settings, pages
2. Change "GitHub Actions" back to "deploy from branch"
3. Select gh-pages, save

### Phase 4: update workflow to use gh-pages

1. TODO: diff workflow

