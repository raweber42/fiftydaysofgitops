## 🔥 Day 11/50: Stop "ClickOps" for Your Access Tokens! Automate Their Lifecycle with Crossplane 🔥
Today, we automate the one task that most teams still do manually: creating access tokens.

If you’re still creating GitLab tokens (or any, really) by hand in the UI every time a team needs to give ArgoCD access to a new repository, you're creating friction and risk. And you lose time. Devs want to deploy, not file a ticket and wait for a copy-pasted token. And you most certainly don't want the token to expire at the worst of times. 🤦‍♂️

### Entry The Crossplane GitLab Provider 🛠️

With the Crossplane GitLab Provider, we teach our Kubernetes cluster to speak "GitLab". The platform team simply installs the provider.

Instead of creating tokens in the UI, you now only create one resource: a `kind: AccessToken` (see screenshot). The platform team defines what that `AccessToken` provisions—a token with the needed scope, an optional expiration date, and tied to a specific group/repository.

And here's the magic: Crossplane automatically creates and injects this token into a Kubernetes `Secret` via `writeConnectionSecretToRef`. 
No security guesswork (like `owner` scopes), no more ClickOps in the Gitlab UI. You define it once and can use it for every group/repo by just adding another Crossplane resource. 

### The benefits ✨
* Auto-rotation possible: Using Crossplane allows you to automatically rotate tokens (more about that in another post).
* Abstracts "ClickOps": No more manual UI work or copy-pasting secrets (especially when combining it with PushSecrets!).
* Creates a GitOps-driven Lifecycle: The token's lifetime is defined in a Git commit.

And because it's just another Kubernetes resource, its entire lifecycle is managed by Git. True GitOps, with auditable security.

How are you managing secrets and access tokens for your CI/CD tools today? 🤔

PS: You can automate token rotation! Use Crossplane Compositions to automatically update the `expiresAt` field every 90 days, forcing a new token to be generated and seamlessly rotated without any human intervention.

PS: That `Secret` Crossplane creates can be your single source of truth. Use a tool like External Secrets Operator (ESO) with PushSecrets to sync this secret *out* of Kubernetes and push it directly into your central secret store, like Vault or OpenBao.

PPS: This is the *perfect* input for your ArgoCD `Credential Templates` (from Day 1). You now have a fully automated, GitOps-driven chain: Crossplane creates the token, stores it in a `Secret`, and ArgoCD's `ExternalSecret` resource consumes it to grant repo access.
