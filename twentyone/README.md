## 🔥 Day 21/50: Stop the Git Overhead! 🔥
You're on-call. An alert fires. You find the 1-line fix.

Now you have to type `git add .`, then `git checkout -b fix-the-thing`, then `git commit -m "fix: the thing"`. It's 3-4 commands for a 10-second change. That's way too much (for me, personally). And yes, you should use a fresh branch for each Merge/Pull Request!

### Entry My `gbc` ZSH Function 🛠️
This is one of my all-time favorite timesavers, and it lives right in my `.zshrc` file. It's a function that bundles all those steps into one command.

I just type `gbc` followed by my branch name, formatted for *Conventional Commits*.

For example, if I run:
`gbc fix-add-missing-value`

This single command automatically does all of this for me:
1.  Runs `git add .`
2.  Runs `git checkout -b "fix-add-missing-value"`
3.  Runs `git commit -m "fix: add missing value"` (It simply formats the commit message!)

Works for all kinds of commits: `gbc docs-specify-how-vcluster-works` creates a commit `docs: specify how vcluster works`. It's simple, but it saved me a lot of typing while being on-call. And typing = time.

✨ The benefits:
➡️ It's FAST: It turns a 4-step chore into a 1-step command.
➡️ Enforces Clean History: It's the laziest way to enforce Conventional Commits.
➡️ Perfect for On-Call: When speed and focus matter, this gets you in and out.

After it's done, I just type `gp` (my alias for `git push`) and my fix is on its way.

What's your #1 time-saving shell function or alias that you can't live without anymore?

PS: Want to save *another* click? Set your push alias to `gp="git push -o merge_request.create"`. This tells GitLab (or GitHub) to automatically create the merge request for you. Saves you one click!
