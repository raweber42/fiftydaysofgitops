## **Day 13/50: That "Is the Disk Full?" Panic? Solve It in 2 Seconds.**
Today, let's talk about a small kubectl plugin that I use *all the time*. It's called "kubectl df-pv".

You seem to have storage issues with a pod. So you want to check if the volume is full. How do you do that again?

Most people do this:
1.  Open Grafana or your Storage Dashboard (e.g. Longhorn UI)
2.  Find the right dashboard
3.  Filter for the right namespace, pod, and PVC

Or, you "kubectl exec" into the pod and run "df -h". Unless the pod is distroless. In that case you have to stop it, mount it to a temporary pod and run the command from there. Or you have several pods with a similar problem. Do you really want to run through this flow for all of them?

Both approaches are not really a way to solve this problem quickly.

I’d like to introduce you to "kubectl df-pv".

It's a simple plugin that gives you a beautiful, "df" (disk free) style report of all your PVCs, right in your terminal.

You just run "kubectl df-pv" (or "kubectl df-pv -A" for all namespaces) and you instantly get a clean table showing:
* The PVC Name
* Total Size
* Used Space
* Available Space
* Percentage Used

When I'm troubleshooting storage issues in k8s pods, this is one of my first commands. I can see in a single glance if any volume is getting dangerously full. No context switching, no opening a browser, just an immediate, actionable answer.

It’s a perfect example of a tool that just reduces friction. It's not flashy, but it saves you 30 seconds. And that adds up.

Read more about the plugin here: https://github.com/yashbhutwala/kubectl-df-pv

What's your favorite "small but mighty" `kubectl` plugin that you can't live without? Let me know in the comments 👇🏼
