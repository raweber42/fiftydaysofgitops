### Day 17/50: Is your ArgoCD Getting Slower and Slower? Let's Tune It for 1000+ Apps!
So, you've crossed the 500-application mark in ArgoCD, and suddenly everything feels... slow. 🐌

Refreshes are timing out, the UI is laggy, and your devs are complaining. This is a classic scaling problem. The Helm chart defaults are great for getting started, but they simply will not cut it at scale. Besides the official docs, there are sadly barely any people sharing their ArgoCD Helm values (or they put them behind paywalls 🙄). So let me share some of the insights I gained from tuning ArgoCD for different companies over the last three years! I want to share two production-tested tuning tips that made a huge differenc for my teams and me.

Now, fair warning: these can be controversial and **highly** depend on your specific workloads (e.g., many small apps vs. a few giant monorepos). But if you're hitting a wall, this is where I'd start.

### Tip 1️⃣: Prefer Fewer, *Heavier* Repo-Servers
A first instinct when the repo-server is struggling might be to scale horizontally. In my team we once ran 12 rather slim provisioned pods. We used a lot of memory (much more than I though would be neccessary), but it was still pretty slow.

After doing some research in the ArgoCD Slack channel and reading about the overhead of running several repo servers in parallel, I switched from 12 "small" pods to 6 (with the same total memory), and my "refresh" operation suddenly felt "snappy" again!

Don't be afraid to vertically scale this component. I've heard of folks running 3000+ apps on a *single*, huge repo-server (I'd stick with at least two or three, though). Keep it simple.

➡️ My (very rough) rule of thumb: Start with ~10Gi of memory per 1000 apps and monitor it. And *please*, set your resource limits/requests! 🚨

### Tip 2️⃣: Unthrottle Your Application Controller
By default, ArgoCD is *very* polite to the Kubernetes API server. It uses a low QPS (Queries Per Second) and Burst, which is great for a small cluster.

But you're running a big environment! Your K8s API server can (and should) handle way more traffic. We can tell the application-controller to be more aggressive.

I played around with some helm values and checked the performance with ArgoCDs Grafana dashboard. What I came up with in the end was:
* `ARGOCD_K8S_CLIENT_QPS: '150'` (Default is 50)
* `ARGOCD_K8S_CLIENT_BURST: '300'` (Default is 100)

This makes application syncs *much* faster because the controller isn't waiting in a self-imposed queue. Your devs will thank you, because the UI (which talks to the controller) also becomes responsive again.

Be aware: Raising these limits can introduce a big strain on your Kubernetes API-Server. So monitor requests and their latency here, too! 

**PS:** That `BURST` setting is especially critical if you have a big monorepo. A single commit can trigger a *ton* of simultaneous sync operations, and that burst capacity is what gets you through the spike.


What's your favorite tweak for the ArgoCD helm values?
