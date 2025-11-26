Day 31/50: Prevent Your Registry to Run Out of Storage with Resource Quotas
Running a self-managed Harbor instance comes with a specific challenge: storage is not infinite.

If you aren't watching what your developers are pushing, you might eventually run into a "Disk Full" scenario. 
The result? The entire registry stops accepting pushes, potentially blocking everyone in the organization.

💡 The Fix: Harbor Resource Quotas
By default, Harbor projects have no quota set whatsoever. Teams - at least according to the Harbor UI - have infinite storage available. But behind every Harbor instance there is a disk with limited storage. To prevent storage exhaustion, you should enforce a hard limit for every project.

Setting a quota acts as a guardrail:

1. It sets a specific maximum amount of storage per team.
2. It provides immediate feedback (an error) if a team tries to push beyond their limit.
3. It ensures that one team cannot consume the entire disk space of the instance.

This allows for secure capacity planning because you know exactly what the maximum worst-case usage looks like. It is always possible to increase the limit if a team has a valid need, but you start from a secure position.

Automate it with Crossplane:

Since the default setting in Harbor is "unlimited," you should enforce this automatically. If you are using Crossplane to provision your projects, simply add the quota to the project (or even better: configure a global default).

This way, every new project is born with a safe limit, ensuring that your registry remains stable regardless of what the pipelines throw at it.


Do you enforce storage limits on your container registry? Let me know in the comments! 👀
