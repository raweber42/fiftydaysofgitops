Day 32/50: Treat Your AI Agent Like a New Hire (Give It an Employee Handbook!)

Context is king. Everyone knows that when it comes to using an AI coding agent.

But here is the catch: Most coding agents are optimized heavily on generic software development, not really on DevOps/Platform engineering.

If you don't guide them, they will give you generic Kubernetes manifests. But you don't want generic. You want CiliumNetworkPolicies, not standard NetworkPolicies. You want your specific ArgoCD application structure with your sync polices, not the default one from the docs. In short: you have conventions and your AI agent should act by them.


📝 The Context File 
You should treat your agent (Copilot, Cursor, Gemini, etc.) exactly like a new engineer who just joined your company. You wouldn't expect them to know your conventions without an onboarding session, right?

While most agents index your monorepo (and therefore understand your setup to some degree), I’ve found it is much better to be explicit.

My Rule of Thumb:
If you find yourself manually typing a specific instruction or best practice to your chatbot more than twice (e.g., "Use KCL instead of Helm" or "Follow this folder structure"), put it in the instructions file.

🧠 The "Cheat Code" to Get Started 
You don't have to write this from scratch. Use your current agent to create the first draft!

Prompt it with something like this:
"Consider this whole monorepo. I want to create a context file for my coding agent. Draft a .github/copilot-instructions.md file that captures our specific infrastructure conventions, naming patterns, and library choices. Follow the best practices outlined here: [LINK]"

The Workflow:
1. Generate: Use your uncustomized agent to get a first draft.
2. Review: Add the specifics that only you know (the "why" behind the "how").
3. Refine: Iterate as your stack evolves.

Take 5 minutes out of your day and make this work today. It turns your agent from a generic coder into a specialized member of your team.

Useful Resources:
- Official Copilot Docs: [https://code.visualstudio.com/docs/copilot/customization/custom-instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- Great Guide on Prompt Files: [https://dev.to/pwd9000/supercharge-vscode-github-copilot-using-instructions-and-prompt-files-2p5e](https://dev.to/pwd9000/supercharge-vscode-github-copilot-using-instructions-and-prompt-files-2p5e)

I’ve linked a sample of my own instructions file in the comments!

PS: I’m using Gemini 3 right now for this. In my opinion, it's the best model for DevOps/Platform Engineering so far.
