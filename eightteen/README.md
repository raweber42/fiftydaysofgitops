## Day 18/50: Give ArgoCD Application Controller Some Rest!
If you're seeing a lot of sync timeouts, or your application controller resource usage is spiking every few minutes, you're probably getting a "thundering herd." All your apps are syncing at the exact same time.

The fix is in your "argocd-cm" ConfigMap. Look for these two settings (these are the default values):

timeout.reconciliation: 120s
timeout.reconciliation.jitter: 60s

If you have a big monorepo or just a lot (500+) of apps, that jitter setting is non-negotiable. This jitter will spread out the syncs and give time to the application controller time to catch up with all the queued applications. So, if the sync timeout is 2 minutes and the jitter is 1 minute, then the actual timeout will be between 2 and 3 minutes. If you have, let's say, a thousand ArgoCD applications, the application controller might not be able to sync them all within this time configured by the default. You might end up with your application ending up in a never ending sync-timeout-loop!

You want to make sure that within "timeout.reconciliation+timeout.reconciliation.jitter" seconds, all applications are able to sync. Be aware, that the higher you set the sum of these values, the less often your autosync will actually run (to be honest: it's better to use webhooks for triggering syncs instead of waiting for that interval every time you push a change).

For 1000+ ArgoCD applications I personally would try something like:

timeout.reconciliation: 180s
timeout.reconciliation.jitter: 120s

This way, you take a lot of load from the application controller by 
1) giving it more time to sync all apps in general (reconciliation 120s ➡️ 180s)
2) distributing individual syncs over more time (jitter 60s ➡️ 120s)

Of course you could just leave everything as is and just give the application controller more resources to be able to deal with the resource spikes. But I personally prefer to save some resources (=cost) and therefore allow autosync to run a bit less often. As I am using webhooks for triggering syncs everywhere anyways, it does not effect my developer's day-to-day work anyways!
 
PS: Don't forget you have to manually restart your repo-server and application-controller pods for this change to take effect!

How are you tuning your Application Controller to keep syncs fast?
