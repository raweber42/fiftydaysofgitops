## 🔥 Day 14/50: Stop "grep"-ing "kubectl"! THIS is your new in-terminal Kubernetes Cockpit 🔥
Let's be honest, how many kubectl aliases do you have defined? "kpods", "klogs", "kdp"? Let's make them all obsolete.

If you're still spending your day piping kubectl through "grep" just to find a pod, or chaining three separate commands just to read a log and then "exec" into a container, you are creating friction for yourself. That context switching adds up, and it's a drag on your time ⏳

### The solution: k9s 🐳
Today, I want to introduce you to k9s. This is my single-pane-of-glass for 99.99% of my day-to-day Kubernetes interactions. I'm not exaggerating when I say I use this tool *every hour*.

It's a terminal-based UI that turns all those slow, multi-command workflows into single keystrokes. I've been using it for about eight months, and I can count on one hand the number of times I've *needed* to drop back to pure kubectl (two times, in case you were wondering).

You don't need to learn 50 commands. You just need 3 or 4 to feel like a superhero:
* ":" to switch resource types (e.g., ":pods", ":cm", ":deploy", or even ":ccnp" for "CiliumClusterwideNetworkPolicy" 🤯)
* "/" to filter by name (goodbye grep!)
* "l" for logs, "s" for shell, "e" for edit, "f" for port-forward
* "0" to switch to all-namespaces view

That's it. You're now faster than anyone using vanilla kubectl.

### The benefits ✨
* One Tool: No more aliases, it's all built-in. It's lightweight and runs right in your terminal
* Real-time: It watches for changes, so you see pods terminating, metrics updating, and rollouts happening *live*
* Handles Everything: It's not just for pods. It handles CRDs, RBAC rules, ConfigMaps, Secrets, Events... anything in your cluster

This tool is one of the biggest time-savers in my day-to-day work, period.

PS: Speaking about saving time: Consider using the alias "g" for "git" 😉 Saves you 66% of key strokes every time.

What's your favourite "small but mighty" CLI tool that you can't live without?
