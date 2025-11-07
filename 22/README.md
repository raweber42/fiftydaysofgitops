## 🔥 Day 22/50: Stop Guessing What Your Operator (or XR) Is Doing! 🔥
You apply a Crossplane XR (or any complex operator CRD) and... what's happening? You try to get all resources in the namespace, but it's just a flat, messy list. You have no idea which Secret or Service belongs to your new resource!

### Check out `kubectl tree` 🌳
This is a simple plugin I found very useful for debugging a Crossplane Composite Resource (XR) today! It visualizes the owner/child relationships of your resources, showing you exactly what's going on.

I was using it to debug my XDatabaseTest Composition. This is a Crossplane XR I built to abstract away database creation for the developer teams; in the background, it just uses the Zalando Postgres Operator.

Instead of hunting around, I ran one command:
`kubectl tree xdatabasetest testteam-db -n testteam`

👀 Look at the screenshot! It gives a very insightful tree view.
* I see my `XDatabaseTest` XR at the very top.
* I can instantly see *everything* the operator is creating on its behalf: the `StatefulSet`, the `Services`, the `Secrets`, the `PDB`, and even the `Pods` underneath.

It’s a simple, fast way to understand the "blast radius" of any resource in your cluster.

PS: Of course, you can use `kubectl tree` for much more than just Crossplane resources! It's a potential lifesaver for operator issues (like cert-manager, cnpg, zalando, external-secrets, etc.).

How are you currently visualizing resource dependencies? 🤔
