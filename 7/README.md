### **Day 7/50: Disarm the "default" Project: A Crucial Step to Secure ArgoCD**
As promised yesterday, today we're tackling the single biggest security hole in a fresh ArgoCD installation: the dangerously permissive `default` project. Out-of-the-box, it's a wildcard permission that allows deploying *anything*, from *any* repo, to *any* namespace in *any* cluster. Imagine someone being able to deploy resources to your `kube-system` namespace! It’s a critical vulnerability. 🚨

By locking it down, we force all activity into the granular, secure, team-specific projects we discussed yesterday.

### Disarming 𝐭𝐡𝐞 𝐃𝐞𝐟𝐚𝐮𝐥𝐭 𝐏𝐫𝐨𝐣𝐞𝐜𝐭: 𝐀 𝐁𝐥𝐚𝐜𝐤𝐥𝐢𝐬𝐭-𝐄𝐯𝐞𝐫𝐲𝐭𝐡𝐢𝐧𝐠 𝐀𝐩𝐩𝐫𝐨𝐚𝐜𝐡 🛡️
The `default` project can't be deleted, so our only option is to render it completely powerless. We achieve this by applying a declarative configuration that strips it of all permissions, turning it into an empty, harmless shell. My example uses the Crossplane Provider for ArgoCD, ensuring this critical safeguard is managed via GitOps.

* **𝐄𝐦𝐩𝐭𝐲 𝐒𝐨𝐮𝐫𝐜𝐞𝐬 & 𝐃𝐞𝐬𝐭𝐢𝐧𝐚𝐭𝐢𝐨𝐧𝐬:** By setting `sourceRepos: []` and `destinations: []`, we explicitly state this project cannot pull code from any repository or deploy to any cluster or namespace. It is completely isolated.

* **𝐔𝐧𝐢𝐯𝐞𝐫𝐬𝐚𝐥 𝐍𝐚𝐦𝐞𝐬𝐩𝐚𝐜𝐞 𝐁𝐥𝐚𝐜𝐤𝐥𝐢𝐬𝐭:** The `namespaceResourceBlacklist` is configured with `group: '*'` and `kind: '*'`. This is a blanket ban, forbidding the project from creating or modifying *any* namespaced Kubernetes resources (like Deployments, Services, etc.).

* **𝐔𝐧𝐢𝐯𝐞𝐫𝐬𝐚𝐥 𝐂𝐥𝐮𝐬𝐭𝐞𝐫 𝐁𝐥𝐚𝐜𝐤𝐥𝐢𝐬𝐭:** Even more critically, the `clusterResourceBlacklist` uses the same wildcard (`'*'`) to block the project from managing any cluster-scoped resources. This prevents it from creating dangerous resources like `ClusterRoles` or `CustomResourceDefinitions`.

With this configuration in place, the `default` project is completely unarmed. Any attempt to deploy an application to it will fail.

This simple manifest is a non-negotiable first step for any production ArgoCD setup. It transforms your security posture from the risky "allow by default" to the secure "deny by default," ensuring all deployments must flow through a properly configured project.

Have you locked down your default ArgoCD project yet? Share your approach in the comments!
