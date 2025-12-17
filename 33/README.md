Day 33/50: A Smoother Way to Handle Registry Credentials in GitLab
We've all done it: creating a new GitLab project and manually adding the username and password variables for pushing to your registry. It works, but it's highly repetitive.

💡 GitLab Harbor Integration
If you use Harbor, you can configure the Harbor integration once - ideally at the Group level - and it automatically makes the necessary credentials available to all your pipelines.

As shown in the screenshot, variables like HARBOR_URL, HARBOR_USERNAME, and HARBOR_PASSWORD are available by default. In combination with Gitlab pipeline templates, building and pushing images to your registry will become as easy as it can get! One import in their .gitlab-ci.yml file and your developers are good to go!

Bonus-Tip: Scoped Credentials with Crossplane
To keep things secure, use Crossplane to create a scoped Robot Account for each team. Add those credentials to the team's GitLab Group Integration.
This way, every team has their own secure identity and you can control, what they can access!

Which Gitlab integrations are you using already?
