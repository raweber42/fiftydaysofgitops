🔥 Day 1/50: Simplifying Private Git Access in ArgoCD: The Power of Credential Templates 🔥

Welcome to Day 1 of my #50DaysOfGitOps series! Let's start with a powerful pattern that drastically simplifies access to private repositories for your ArgoCD instance.

**The Problem**: As your organisation grows, so does the number of Git repositories for which (in most cases) you need to manage credentials because they are private. You find yourself creating and managing individual access tokens for every single repository which you want to connect to ArgoCD. It's a repetitive, error-prone process that does not scale.

I remember numerous instances of being interrupted by a developer because he created a new repository in Gitlab and I had to configure and whitelist it for deploying on ArgoCD 🙄

**The Solution**: Combine ArgoCD's native Credential Templates with the External Secrets Operator (ESO) for a fully automated solution!

Instead of one secret per repo, ArgoCD lets you create a single credential for a URL prefix (e.g., https://lnkd.in/eFu86sJA). 𝘐𝘵 𝘵𝘩𝘦𝘯 𝘢𝘶𝘵𝘰𝘮𝘢𝘵𝘪𝘤𝘢𝘭𝘭𝘺 𝘢𝘱𝘱𝘭𝘪𝘦𝘴 𝘵𝘩𝘢𝘵 𝘤𝘳𝘦𝘥𝘦𝘯𝘵𝘪𝘢𝘭 𝘵𝘰 𝘢𝘯𝘺 𝘳𝘦𝘱𝘰𝘴𝘪𝘵𝘰𝘳𝘺 𝘶𝘯𝘥𝘦𝘳 𝘵𝘩𝘢𝘵 𝘱𝘳𝘦𝘧𝘪𝘹 𝘵𝘩𝘢𝘵 𝘥𝘰𝘦𝘴𝘯'𝘵 𝘩𝘢𝘷𝘦 𝘪𝘵𝘴 𝘰𝘸𝘯 𝘴𝘱𝘦𝘤𝘪𝘧𝘪𝘤 𝘴𝘦𝘤𝘳𝘦𝘵!

Manually creating these templates in the UI or CLI (= "argocd repocreds add […]") is good, but managing them declaratively is better. I recommend using ESO to create and sync these template secrets directly from a central secret store (like Vault/OpenBao).

The screenshot shows an example for an ExternalSecret manifest that creates a credential template for an entire GitLab group ("teamone"). It fetches the access token from your secret store and generates the required secret for ArgoCD to use. You can find the yaml manifest in my dedicated Github repository: https://lnkd.in/eJiqhmSM

With this single manifest, you grant ArgoCD access to all repositories within "my-gitlab-group" declaratively. Adding a new group is as simple as creating another ExternalSecret.
For a deeper dive into how ArgoCD handles this, check the official docs: https://lnkd.in/etTtPVhn



QUESTION: Are you already using Credential Templates for ArgoCD? If not, what is holding you back?




PS: Especially in larger organisations it is very useful to have different levels of granularity for repository access management. Leveraging ArgoCD's RBAC capabilities, you can make sure that every team can only deploy from repositories that they are supposed to!

PPS: Technically, you could just create a Kubernetes Secret with the corresponding label, but I strongly advise using a secret storage client like ExternalSecrets instead. 🔐

PPPS: If you want to go even further, you can create (and rotate) your group access tokens with Terraform or Crossplane!
