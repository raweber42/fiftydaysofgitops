🔥 Day 23/50: Optimising Harbor Storage: The Power of Retention Policies 🔥

If your CI pipelines are constantly pushing images, your Harbor container registry storage consumption is likely growing over time. 



Storing every temporarily used image of every of your developer team's pipelines quickly becomes a platform expense. And at some point, you might be out of storage and pipelines will fail (yes, I've been there). Let's avoid this!



As platform engineers, our job is to keep pipelines running and manage this cost efficiently. The solution I have been using is to implement automated Harbor Retention Policies with Crossplane.



🏷️ Establishing Image Tagging Standards

To enable automated cleanup without risking stability, clear communication with development teams on tagging is crucial:



1️⃣ Stable Tags (Production): Images intended for production or long-term stability *must* use Semantic Versioning (SemVer) tags (e.g., `v1.2.3`). We guarantee retention for these critical artifacts.

2️⃣ Ephemeral Tags (Testing/Review): CI/CD pipelines should use tags with non-SemVer patterns (e.g., branch names like "review-<MERGE_REQUEST_NAME>"). These are considered temporary builds.



💾 Harbor Retention Policy Implementation

We can use declarative policies (managed with Crossplane, as shown in the screenshot) to enforce this lifecycle automatically, reducing manual intervention:



1️⃣ Retain Production: We configure a rule to *always retain* artifacts that match the SemVer pattern (`{v*.*.*,*.*.*}`). This is our stability guarantee.

2️⃣ Cleanup Ephemeral: We implement a policy to delete any artifact not pulled within the last 30 days. This targets old, unused testing, and review images.



This strategy effectively keeps storage cost low and registry performance high while simultaneously enforcing required tagging standards. The 30-day period (or the tagging convention) can be easily adjusted based on your typical deployment and rollback windows.



PS: The additional benefit of using Crossplane for configuring the policies (instead of clicking through the Harbor UI) is, that even if someone (accidentially) adjusts the policies, Crossplane will reconcile them back to the configuration that you defined in code!



How do you make sure that your registry's storage does not grow endlessly? Let me know in the comments!

