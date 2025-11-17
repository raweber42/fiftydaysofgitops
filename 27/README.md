Day 27/50: Stop Wasting Time on Flaky CI Runners
I recently had some of our developer's Gitlab CI pipelines failing because we were migrating some workloads in the background. The devs complained. I told my colleagues that we should announce these kind of operations in order to make our
devs aware, that jobs might be failing. But then my colleague said something, that made me change my mind: "They should be aware, that pipelines that are running in our self-hosted Kubernetes environment might fail occasionally. Why don't they retry them automatically?"

Self-hosted CI runners are powerful, but they are not always 100% stable. They will fail due to some transient errors.

What happens is always the same. A developer's pipeline fails with a "runner_system_failure". They message you. You're pulled away from your work, just to tell them "please just rerun it first" because you see that a node was temporarily unavailable. This is a huge waste of time for everyone.

Instead of making this a human problem, make the pipeline fix itself. GitLab has a `retry` keyword for exactly this.

You can tell a job to automatically retry if it fails. This simple change will catch and resolve most of those transient runner failures without you ever hearing about them.

The best place to put this is in the `default:` section of your `.gitlab-ci.yml`, especially if you maintain the templates for your developers. This way, it will apply to all jobs in that pipeline!

A simple setup is just:

default:
  retry: 2

This is good, but it will retry ALL failures, including real test failures.

You can be more specific. Tell it to ONLY retry on a runner system failure.

default:
  retry:
    max: 2
    when:
      - runner_system_failure

Now, if a developer's code fails a test, the pipeline fails, as it should. But if the runner itself flakes, GitLab just tries again.

Your developers are happier because their pipelines self-heal, and you are happier because you get to focus on your real work instead of answering "can you re-run this?"
