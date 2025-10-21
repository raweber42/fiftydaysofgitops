## 🔥 Day 8/50: Your Registry is Down! GitOps Strategies for Surviving an Outage 🔥
Today I will teach you three approaches on how to smoothly survive an outage of a container registry you are relying on.

Your cluster is on fire, imagePullBackoffs are all over the place. The cause? A major container registry outage. Sound familiar? It was a reality for many today with Docker Hub (sorry for jumping on that topic like everybody else, but this post will give you some good insights 😉).

A GitOps pipeline is only as reliable as its weakest link, and dependency on a single, remote registry is exactly that. If it goes down, your cluster can't pull new images or even reschedule pods on new nodes.

Let's make sure next time you are prepared! Here’s how you make your platform resilient for such an outage.

### Level 1: The Quick Win 🏃‍♂️

Set your "imagePullPolicy" to "ifNotPresent". This is your first line of defense. It tells Kubernetes a simple thing: "If you already have this exact image on the node, don't bother re-pulling it." This prevents running pods from failing on a simple restart, but it won't help you schedule a pod on a node that doesn't have the image cached. It's a bare-bone quick fix - and a lot of manual work if you have a lot of deployments - but we can do better.

And remember to set it back to "always" after the outage!

### Level 2: The Fortress (Proxy Cache) 🏰

Deploy a caching proxy like Harbor. Harbor sits between your cluster and external registries (ECR, Docker Hub, GHCR, etc.). When you pull an image for the first time, Harbor caches it. All subsequent pulls come from your local Harbor proxy at lighting speed.

This way you will:
* Become outage proof: your cluster pulls from your local cache, which is completely isolated from the external outage.
* Avoid Rate Limits: You stop hitting pull limits on registries like Docker Hub (and can save cost for an enterprice licence 💡)
* Faster Pulls: Caching locally means lightning-fast image pulls

### Level 3: The Decentralized Swarm (P2P) 🐝

For ultimate resilience, use a peer-to-peer (P2P) image distribution tool like **Spegel**. Spegel turns your cluster into a self-sufficient image-sharing network.

When a node needs an image, it first asks its peers in the same cluster. If another node has it, it gets copied over the local network. The external registry is only contacted if *no node* in the cluster has the image. This drastically reduces external calls and contains the blast radius of an outage.

These layers of defense turn your infrastructure from fragile to antifragile. You're not just hoping an outage won't happen; you're engineering a system that expects it. True GitOps resilience.

If you are using k3s, Spegel can be activated by adding one flag to your config: https://docs.k3s.io/installation/registry-mirror



PS: If you want to run a smoke-test on how reliable your infrastructure is for such an outage, simply block access to your container registry for a while (e.g. with a networkpolicy). This way you can simulate an outage!

How are you protecting your clusters from registry failures? 👇
