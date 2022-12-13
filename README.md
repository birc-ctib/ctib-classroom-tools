# ctib-classroom-tools

Tools for working with CTiB GitHub Classrooms.

You might want to check out all the repos in this organisation, since you will be working with almost all of them. You can do this with a command line like this in `bash`:

```bash
gh repo list birc-ctib -L500 | while read -r repo _ ; do gh repo clone $repo $repo; done
```

If you also want the solutions (those I have made, at least, it is)

```bash
gh repo list birc-ctib-solutions -L500 | while read -r repo _ ; do gh repo clone $repo $repo; done
```

For these commands to work, you need [GitHub CLI](https://cli.github.com) installed.

## Assignments and repo setups

Each programming exercise or project is a template repository that GitHub Classroom copies to create repos for students. Each of these template repositories should contain a description of the exercise/project and any template or test code needed. There should also be a GitHub Workflow for testing submissions, if this is feasable to make.

Since the assignments share some basic setup code to run Workflows, we put this in a separate repo that we can pull from. (We cannot currently use branches for this, although it would be nice to have each exercise as a separate branch in the same repo, since Classroom drags the entire template repo along, stripping history,and giving the students the main branch as their main branch).

The solution right now is to have one repo, `birc-ctib/base-project`, holding the generic code, then a template repo for each concrete project that can pull from `base-project` as a remote. Put all the generic code there and the assignment specific code and info in the other repositories. Don't put a README or anything like it in the `base-project`, since that will cause merge conflicts.

When you create a new assignment repository, connect it to the base using

```sh
> git remote add base https://github.com/birc-ctib/base-project
> git fetch base
> git merge base/main --allow-unrelated-histories
```

You only need the `--allow-unrelated-histories` the first time you merge; after that, you can just do

```sh
> git fetch base
> git merge base/main
```

to fetch updated code.

Since remote information is not something that git stores in the repositories, you need to connect the repo each time you clone it to somewhere else, but you still only need the `--allow-unrleated-histories` once; it will remember that the two repositories are related after the first time.

To make thing simpler, you can use the script `new-project.sh` to create new projects--it will create a new project repo and do the initial merge--and you can use `merge-base.sh` to merge new code in from the base repository.

## Setting up a new class

When you are about to run a new class, create a new organisation for it (that way you can handle repos and administration access separately year for year). For year 20xx, create birc-ctib-20xx, for example.

In that repo, go to Settings > Member privilages and change Base permissions to Read. Otherwise, the students cannot invite each other to review (and it is nice to get them to do that).

Then, setup a GitHub Classroom and all the exercises--I don't think you can automate this, unfortunately.

In [GitHub Classroom](classroom.github.com) click create a **New classroom** (a big green buttom). Pick the organisation for it (the one you just made on Github), and give it an appropriate name, like *CTiB 20xx*. Follow the instructions from there on, until you have completed the setup.

When you have created the classroom, you can create the assignments. This is the slow and tedious part... For each exercise in the entire class, you need to make a GitHub Classroom exercise. That gives you a link, and the students need that link to start the exercise.

I have tried setting something up to make it easier to handle in [birc-ctib/schedule](https://github.com/birc-ctib/schedule) by putting the links in files that are then weaved into Markdown files, but it isn't perfect, because you need to keep these links hidden. You don't want the whole internet to click on the links and swarm the classroom. So, you need to copy the results somewhere. I didn't get far enought to make a solution for that...the main problem is links that are relative in the repo, which they can't be if you keep the repo private.

Before you add an exercise, though, check if there are issues with it. Some of the exercises didn't work as intended, and I didn't have time to fix all of them.
