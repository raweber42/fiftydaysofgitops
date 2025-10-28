### Day 15/50: Build with Confidence: Unit Test Crossplane Compositions
Let's talk about something that's a huge pain when you're building those awesome custom platform APIs ("Compositions") we discussed back on Day 5.
When you write a complex `Composition` (to be fair, they all look complicated at first), how can you be sure that I works as intended? 🎯

There is a much, much better way than a frustrating "apply and pray" feedback loop. It's the "crossplane render" command.

This is a local-first "unit test" for your Compositions, and it's built right into the Crossplane CLI.

The best part? *It doesn't need a live Kubernetes cluster.* It uses your local Docker daemon to run the exact same Composition Functions (like "function-patch-and-transform") that your cluster would.

You just feed it your local files:
1.  A simple YAML of your custom resource (the XR [Composite Resource], like your "kind: Database").
2.  Your "Composition.yaml".
3.  The "Function.yaml" (so it knows what Docker image to run).

You run

    crossplane render xr.yaml composition.yaml function.yaml
    
and it spits out the *exact* YAML manifests (your "Deployment", your "Secret", your "NetworkPolicy") that it will create.

In an instant, you can see if your patches worked, if your template logic is correct, and if the final resources look exactly as you intended. You can iterate 10 times in a minute on your laptop instead of 10 times in an hour on a dev cluster.

This is my go-to tool for preparing live demos (like for my talk at DevOps Meetup Zurich on Wednesday 😉). 

PS: This tool is also a lifesaver when you're *writing* your own custom Composition Functions in Go or Python!

How are you creating Compositions right now? Are you using `render`? Let me know in the comments!
