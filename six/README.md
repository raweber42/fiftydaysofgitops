Day 6/50: Explicit Permissions ONLY: How ArgoCD Projects Eliminate Deployment Vulnerabilities 
If in your ArgoCD environment everyone can deploy anything, from any repo, to any cluster - you have a critical security gap. The default ArgoCD Project is dangerously permissive, and it must be locked down! 🔒 (More about that in my post tomorrow!)

It’s time to move beyond implicit trust and implement explicit permissions that strictly define who can do what, and where.

𝐀𝐫𝐠𝐨𝐂𝐃 𝐏𝐫𝐨𝐣𝐞𝐜𝐭𝐬: 𝐃𝐞𝐟𝐢𝐧𝐢𝐧𝐠 𝐖𝐡𝐨, 𝐖𝐡𝐚𝐭, 𝐚𝐧𝐝 𝐖𝐡𝐞𝐫𝐞 🛠️
ArgoCD Projects aren't just for organisation; they are your primary mechanism for enforcing Least Privilege and creating concrete boundaries for your teams. The platform team uses them to enforce these critical security controls:

 * 𝐖𝐡𝐨 (𝐀𝐜𝐜𝐞𝐬𝐬 𝐂𝐨𝐧𝐭𝐫𝐨𝐥): Custom Roles and Policies ensure teams only see and interact with their own applications. For example, granting sync and update access to the “team-a” group is limited only to applications tagged with the “team-a” project.

 * 𝐖𝐡𝐚𝐭 (𝐑𝐞𝐬𝐨𝐮𝐫𝐜𝐞 𝐒𝐜𝐨𝐩𝐢𝐧𝐠): The resource whitelist (“namespaceResourceWhitelist”) explicitly defines which Kubernetes kinds (like Deployment, Service, ConfigMap) a team is allowed to create. Moreover, "clusterResourceWhitelist" can be used to locking down deploying cluster-scoped resources completely!

 * 𝐖𝐡𝐞𝐫𝐞 (𝐃𝐞𝐩𝐥𝐨𝐲𝐦𝐞𝐧𝐭 𝐓𝐚𝐫𝐠𝐞𝐭𝐬): The destination whitelist (destinations) strictly limits where code can land. You ensure Team A can only target its designated “team-a” namespace on approved clusters.

 * 𝐅𝐑𝐎𝐌 𝐖𝐇𝐄𝐑𝐄 (𝐒𝐨𝐮𝐫𝐜𝐞 𝐈𝐧𝐭𝐞𝐠𝐫𝐢𝐭𝐲): The Source Repository Whitelist (“sourceRepos”) enforces that deployments can only originate from explicitly approved, trusted Git repositories.

It’s a best practice to separate high-privilege platform projects (highly restricted to admins) from secure team-specific projects (built on explicit whitelisting and least privilege for everyone else).

This disciplined approach transforms ArgoCD from a bare deployment tool into a secure delivery platform where security is enforced by design.

Have you started defining explicit per-team projects in your environment? If not, what else are you using ArgoCD Projects for? 🤔
