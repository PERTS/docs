# How to Run a Maintenance Window

## First time

1. Create a `maintenance` branch.
2. Add a branch entry to `branch_environment.json` that:
  - points to the production application id
  - points to a version called `maintenance`
3. Change the landing/login page so
  - it announces that the app is down for maintenance
  - has no way to log in
4. Commit your changes to the branch and push.
5. Deploy your code with `./deploy.py --promote` which will send all traffic to the `maintenance` version
6. Check that the app shows your changes at the "production" domain.
7. Merge working branch and let codeship build and deploy. Now your new code is deployed.
8. Make any changes to the production database.
9. Visit the `production` version with `production-dot-myplatform.appspot.com` and make sure your changes behave correctly.
10. Migrate traffic ("promote") to `production` version in the cloud console in App Engine > Versions.
11. Cherry-pick the `branch_environment.json` file commit to master and push.

## Once set up is done

Once the maintenance version is created, we can shorten to these steps:

1. Migrate traffic ("promote") to `maintenance` version in the cloud console in App Engine > Versions.
2. Check that the app shows the maintenance message at the "production" domain.
3. Merge working branch and let codeship build and deploy. Now your new code is deployed.
4. Make any changes to the production database.
5. Visit the `production` version with `production-dot-myplatform.appspot.com` and make sure your changes behave correctly.
6. Migrate traffic ("promote") to `production` version in the cloud console in App Engine > Versions.
