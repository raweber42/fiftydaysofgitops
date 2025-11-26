Day 29/50: Stop the Mutability Blindspot for your Images

You deployed version 1.2.0 to production. It works perfectly. A week later, an autoscaling event triggers, a new pod starts pulling version 1.2.0, and suddenly the application crashes.

Why? Because someone rebuilt the image and pushed it to the same 1.2.0 tag. The name stayed the same, but the code changed. This destroys reproducibility and makes reliable rollbacks impossible.


The fix is enforcing Tag Immutability in your registry. This means once a tag is pushed, it is locked. It cannot be changed. A pipeline trying to do so will fail.

However, you need to be pragmatic. Most likely, your CI/CD pipelines rely on mutable tags for testing.

A good starting point for a tag policy would be:
1. Production tags (semver like "1.0.0") are immutable. No exceptions.
2. Development tags are mutable. We explicitly whitelist patterns like latest, dev, nightly, review-*, and release-* to allow overwriting.

This gives us the best of both worlds: rapid iteration during development and absolute certainty for production releases.

PS: Use Crossplane to define these immutability rules. Don't rely on clicking somewhere in the Harbor UI and praying that no one will accidentially change it.

Do you allow overwriting tags in your container registry?
