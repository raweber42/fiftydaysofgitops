Day 26/50: Crossplane ImageConfig — Global Credentials for Private Registries

How do you supply credentials when pulling Crossplane Functions or Providers? One answer: ImageConfig.

THE PROBLEM
If you use private Crossplane Functions or Providers from your own private container registry (or you use a proxy cache like Harbor), the first time Crossplane tries to pull the package, it fails. Why? Authentication. It doesn't have the credentials for your private registry.

THE SOLUTION
This is where ImageConfig comes in. It's a global, "set it and forget it" way to manage registry credentials for all your Crossplane packages.

Think of it just like the `imagePullSecret` you'd add to a Deployment.

You create a single `ImageConfig` resource. In it, you tell Crossplane:
1.  What image prefix to match (like `my-private-registry.com/`)
2.  What Kubernetes secret to use for authentication (like `my-registry-creds`)

That's it. You define it once.

From that moment on, any time Crossplane's package manager tries to pull any package (Provider, Function, etc.) that matches that `my-private-registry.com/` prefix, it will automatically use the credentials you specified.

If you ask yourself: "Why not just pull from the public crossplane registry?", think about the recent AWS outage 😉
