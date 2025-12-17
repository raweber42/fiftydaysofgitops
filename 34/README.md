Day 34/50: Is Your ArgoCD Sharding Actually Fair?

If you are running ArgoCD at scale, you are likely running multiple replicas of the `application-controller`. This creates "shards" to distribute the work of reconciling your clusters.

But is that work distributed fairly?

The default (legacy) sharding algorithm is UID-based. It’s pretty random. This causes problems if your clusters have vastly different sizes (e.g., a massive internal "dev" cluster with 2k apps vs. medium-sized "prod" clusters).

You might end up with Shard 1 struggling to reconcile the massive "dev" cluster that is everyone's playground, while Shard 2 and 3 are sitting idle handling the smaller ones.

How to check?

Use the power of ArgoCD's CLI:
`argocd admin cluster shards`

If you see a massive imbalance (150%+ for certain shards), you have room for improvement.

One Solution: Consistent Hashing
If you are seeing this imbalance, consider switching your sharding algorithm to `consistent-hashing`.
It uses a bounded loads algorithm to ensure a much smoother distribution. It also minimizes reshuffling when you add/remove shards (unlike `round-robin`, which can cause a "thundering herd" rebalance).

*Note: This is technically an Alpha feature, but results from the community and myself are very promising.*

You don't like Alpha features?:

If you want to stick to the stable `legacy` mode, here is a counter-intuitive tip: 

Try reducing your application-controller replicas!

Why? It’s the law of large numbers.
If you have fewer shards, each shard manages *more* clusters. This larger "bucket" makes it easier to absorb the impact of one massive cluster. If you have too many small shards, the one unlucky pod that gets the "Giant Cluster" will instantly be overloaded.

Check your shards today. Are they balanced? ⚖️
