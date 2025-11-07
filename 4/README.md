## 🔥 **Day 4/50: GitOps for GitOps — Let the Git Generators Create Your ArgoCD Applications\!** 🔥
Today, we automate ArgoCD Application creation in a GitOps fashion.

If you’re still creating one ArgoCD Application per cluster or environment, you’re doing it the hard way. Every tweak, every new environment, every client => another manifest => another potential source for bugs. That’s not GitOps. 🤦‍♂️

### Entry Git Generators ⚙️

The **ApplicationSets** below instruct ArgoCD to create multiple ArgoCD Applications from a single template.

In my setup (see manifest below 👇), I use **two Git generators** — one for "test", one for "prod".

* The first generator, under the ##TEST## block, scans for Helm value files under "test/values/*.yaml".
* The second generator, under the ##PROD## block, scans for "prod/values/*.yaml".

Each YAML file found by the generators is treated as a set of parameters, which is then used to render a complete Application manifest automatically using the ##TEMPLATE## section.

Add a new YAML file (e.g., "test/values/client-x.yaml") for a new environment or customer → commit → boom 💥 ArgoCD's ApplicationSet controller instantly creates a new Application with all the neccessary configuration for that.

No manual edits. No drift. No wasted time.

### 𝗪𝗵𝘆 𝗜𝘁 𝗠𝗮𝘁𝘁𝗲𝗿𝘀 🧠

  * DRY principle, applied to GitOps
  * One template defines *all* your clusters
  * A single commit deploys Applications across your entire fleet

And yes — the ApplicationSet controller even has its **own webhook endpoint**. Push a new file → webhook triggers → instant sync. No polling delay. 🚀

### 𝗣𝗿𝗼 𝗧𝗶𝗽: Use other generators, too

You can use the cluster generator such that every cluster you register with ArgoCD automatically gets your standard stack (e.g. cert-manager, crossplane...) — no human in the loop. This is a very powerful automation step multi-cluster environments! See the full list of generators here: [https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators/\#generators](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators/#generators)

How are you creating multi-cluster deployments with ArgoCD today? 🤔
