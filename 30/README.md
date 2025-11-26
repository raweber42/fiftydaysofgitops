Day 30/50: Give Your Developers Custom Status Updates with Crossplane 💡
Imagine you have a "Database" resource which obfuscates away the provisioning of a DB (on-prem or in the cloud) via Crossplane Compositions.

If your dev creates an instance of your composite resource definition (XRD), it might take a minute or two to provision. If you use something like ArgoCD for visibility, your dev will potentially be staring at the "Database" resource, wondering if/when the database is ready.

This is where the "status-transformer" function comes in!
It observes the status of the XR and - based on some rules you give it - adds a status message of your choice (here: "Type: Developer").

This way, you can give more insights to your devs on what is going on. And you can translate error messages for your developers! 

"Region XYZ is invalid"

suddenly becomes something like

"Your selected region is not available, please review your config and try another region"

A cryptic "ReconcileError" suddenly becomes an easily digestible error message that the dev can act upon.

If you are building abstractions for your devs with Crossplane Compositions, "status-transformer" is a must!
