DAY 28/50: Is Your Deployment Running Out of Resources? This Dashboard Gives You the 2-Second Answer.
An app is slow, or a pod is restarting. What's your first guess? Resources.

But now the hunt begins. You're kubectl top pod-ing, checking with k9s, or worse, manually checking different metrics in Grafana. This is high-friction for a simple, vital question that pops up all the time!

MY "GO-TO" RESOURCE DASHBOARD
This is one of the most simple, "boring," and powerful dashboards I have. It's not fancy, but I use it constantly. It's designed to answer two questions fast.

It has just 3 simple selectors: Cluster, Namespace, Deployment.

Then, it shows you exactly:
1. Memory Usage vs. Memory LIMIT (Answers: "Is this pod about to be OOMKilled?")
2. CPU Usage vs. CPU REQUEST (Answers: "Did I request enough CPU? Am I being throttled?")

It's a powerful first indicator. I use this all the time to check on all my applications, e.g. to see if the postgres-operator is under memory pressure or an ArgoCD component is using much more CPU than defined in it's `request`.

(You'll notice I don't chart CPU limits. That's a huge topic on it's on, but bottom line is: I don't set them. We can debate that another time!)

This is a "must-have" for any team running workloads on Kubernetes.

I'll share the JSON for this in the comments. You can import it directly into your Grafana instance in 30 seconds. (You might need to adjust this according to your needs, though). Of course it's easy to support also StatefulSets or other kinds of Kubernetes resources.

How are you currently checking this your application's resource usage?

PS: This is the PERFECT example of a dashboard to use with your ArgoCD Deep Links (from Day 20!). A dev sees a failing app, clicks a custom link, and automagically lands right here with the namespace and deployment pre-selected.
