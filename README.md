# Testing converting a GitHub repository from branch-based to gh-pages workflow

By default, the deploy-from-branch has two large downsides:

1. Deploy history not visible in a gh-pages branch
2. Workflow steps are fixed, one-size-fits-all

Here we will create a deploy-from-branch repo and convert it to workflow which
updates the gh-pages branch as part of the deploy.
