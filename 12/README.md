🔥 **Day 12/50: Stop Manually Copy-Pasting Secrets! Automate Your Vault with PushSecrets.** 🔥
If you're still manually copy-pasting that generated token from Kubernetes into your central Vault or OpenBao instance, read on!

In yesterday's post, we created a GitLab token with Crossplane and stored it in a Kubernetes Secret. That's a great first step, but what if other tools need that token? Or what if the cluster has a disaster and that local secret is lost?

## The Solution: The "PushSecret" 🛠️

With the External Secrets Operator (ESO), we can complete the automation loop. Most people know ESO for *pulling* secrets *from* Vault, but it can also *push* secrets *to* it using the "PushSecret" resource.

Instead of manually copying, we create one PushSecret manifest that:

1.  **Selects** the source Kubernetes Secret (the one Crossplane created).
2.  **Targets** our central "ClusterSecretStore" (Vault, OpenBao, GCP/AWS/Azure Secrets Manager, etc.).
3.  **Writes** the secret data to a specific "remoteKey" (path) inside the store.
4.  **Uses** "updatePolicy: Replace" to create a *new revision* in the secret store every time the source Secret changes (e.g., during token rotation).

## The Benefits ✨
This closes the loop and unlocks a true GitOps workflow for your secrets.

* Fully Automated Pipeline: Crossplane creates the token ➡️ PushSecret automatically syncs it to Vault. Zero manual steps.
* Centralized & Versioned: Your secret now lives in your central, backed-up secret store, with a full version history. PLUS: You keep your old revisions!
* Auditable & Secure: The entire secret lifecycle, from creation to storage, is declarative and managed via Git.

And because it's just another Kubernetes controller, ESO continuously reconciles. The moment Crossplane rotates a token, PushSecret detects the change and pushes the new version to Vault. This PushSecret is the missing "glue" that connects your cluster-generated secrets to the rest of your infrastructure.


## Tip: Prevent Data Loss 💡

My example uses "deletionPolicy: None". This is a critical safety feature! It means if you delete the "PushSecret" manifest (or the whole cluster), the secret stays in Vault. This conveniently prevents accidental data loss.


PS: This pattern obviously isn't just for Crossplane. You can use PushSecrets to back up *any* generated secret in your cluster. Think cert-manager! Automatically push your "tls.crt" and "tls.key" to Vault as soon as they're issued or renewed.

Are you using PushSecrets already? Or is you process still manual? 🤔
