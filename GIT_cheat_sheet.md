
- [branches](#branches)
  - [Navigating branches](#navigating-branches)
  - [creating branches](#creating-branches)
  - [checking out branches](#checking-out-branches)
- [basic actions](#basic-actions)
  - [add files / stage files for commit](#add-files--stage-files-for-commit)
  - [commit files](#commit-files)
  - [undo the commit you just did](#undo-the-commit-you-just-did)
- [instead of .gitignore -- just exclude for yourself](#instead-of-gitignore----just-exclude-for-yourself)
- [basic workflow examples](#basic-workflow-examples)
  - [simple commit and push upstream](#simple-commit-and-push-upstream)
  - [VIM / text editor commands to complete a commit](#vim--text-editor-commands-to-complete-a-commit)
  - [merging in master to your branch (no conflicts)](#merging-in-master-to-your-branch-no-conflicts)
  - [merging in master to your branch (there are conflicts)](#merging-in-master-to-your-branch-there-are-conflicts)
  - [Using git fetch to Fetch Changes Then Merge Using Commit Hash](#using-git-fetch-to-fetch-changes-then-merge-using-commit-hash)
- [deleting a branch](#deleting-a-branch)
- [Reversing git actions](#reversing-git-actions)
  - [Undo `git add` for uncommitted changes with:](#undogit-addfor-uncommitted-changes-with)
  - [To unstage all changes for all files:](#to-unstage-all-changes-for-all-files)
- [delete a local branch](#delete-a-local-branch)
- [delete a remote branch](#delete-a-remote-branch)

# terminology

- **Working tree:** The set of nested directories and files that contain the project that's being worked on.
- **Repository (repo):** The directory, located at the top level of a working tree, where Git keeps all the history and metadata for a project. Repositories are almost always referred to as repos. A bare repository is one that isn't part of a working tree; it's used for sharing or backup. A bare repo is usually a directory with a name that ends in .git—for example, project.git.
- **Hash:** A number produced by a hash function that represents the contents of a file or another object as a fixed number of digits. Git uses hashes that are 160 bits long. One advantage to using hashes is that Git can tell whether a file has changed by hashing its contents and comparing the result to the previous hash. If the file time-and-date stamp is changed, but the file hash isn’t changed, Git knows the file contents aren’t changed.
- **Object:** A Git repo contains four types of objects, each uniquely identified by an SHA-1 hash. A blob object contains an ordinary file. A tree object represents a directory; it contains names, hashes, and permissions. A commit object represents a specific version of the working tree. A tag is a name attached to a commit.
- **Commit:** When used as a verb, commit means to make a commit object. This action takes its name from commits to a database. It means you are committing the changes you have made so that others can eventually see them, too.
- **Branch:** A branch is a named series of linked commits. The most recent commit on a branch is called the head. The default branch, which is created when you initialize a repository, is called main, often named master in Git. The head of the current branch is named HEAD. Branches are an incredibly useful feature of Git because they allow developers to work independently (or together) in branches and later merge their changes into the default branch.
- **Remote:** A remote is a named reference to another Git repository. When you create a repo, Git creates a remote named origin that is the default remote for push and pull operations.
- **Commands, subcommands, and options:** Git operations are performed by using commands like git push and git pull. git is the command, and push or pull is the subcommand. The subcommand specifies the operation you want Git to perform. Commands frequently are accompanied by options, which use hyphens (-) or double hyphens (--). For example, git reset --hard.

# checking git version
```
git --version
```

# configure git

```
git config --global user.name "<USER_NAME>"
git config --global user.email "<USER_EMAIL>"
git config --list
```

# make a directory

```
mkdir [insert directory_name]
cd [directory_name] # to navigate to directory
```

# initialize repo 
initialize your new repository and set the name of the default branch to main:

```
git init --initial-branch=main
git init -b main
-- or --
git init
git checkout -b main
```
# status

```
git status
```

# Use an ls command to show the contents of the working tree:

```
ls -la
```
you should ensure that there is a subdirectory named `.git` here 

**git status**
Git status displays the state of the working tree (and of the staging area. It lets you see which changes are currently being tracked by Git, so you can decide whether you want to ask Git to take another snapshot.

**git add**
git add is the command you use to tell Git to start keeping track of changes in certain files.
The technical term is staging these changes. You'll use git add to stage changes to prepare for a commit. All changes in files that have been added but not yet committed are stored in the staging area.

**git commit**
After you've staged some changes for commit, you can save your work to a snapshot by invoking the git commit command.

Commit is both a verb and a noun. It has essentially the same meaning as when you commit to a plan or commit a change to a database. As a verb, committing changes means you put a copy (of the file, directory, or other "stuff") in the repository as a new version. As a noun, a commit is the small chunk of data that gives the changes you committed a unique identity. The data that's saved in a commit includes the author's name and e-mail address, the date, comments about what you did (and why), an optional digital signature, and the unique identifier of the preceding commit.

**git log**
The git log command allows you to see information about previous commits. Each commit has a message attached to it (a commit message), and the git log command prints information about the most recent commits, like their time stamp, the author, and a commit message. This command helps you keep track of what you've been doing and what changes have been saved.

# modifying a file
after modifying a file

# see what's changed with git diff
```
git diff
git diff HEAD^ 
```
will produce output if the working tree, index and head are NOT in agreement

# modifying .gitignore
```
code .gitignore
```

add following to file to instruct Git to ignore files that have file names ending in .bak or ~.

```
*.bak
*~
```

# create subdirectory
note that Git does not consider adding an empty directory to be a change 
this is because GIT tracks only changes to files, not changes to directories 
sometiems you want an empty directory as a placeholder, so you can create an empty file often called
`.git-keep` in a placeholder directory 

```
touch CSS/.git-keep
git add CSS
```

# see list of commits 
```
git log --oneline
```

# recovering a deleted file
1. delete a file
```
rm file.html
```
2. use an `ls` command to verify that file.html was deleted
```
ls
```
3. recover the file
```
git checkout -- file.html
```

# practice recovering a file that was deleted: git rm

```
git rm file.html
```
when you use git rm - it deletes the file but also records the deletion in the index
so you have to unstage the deletion with
```
git reset HEAD file.html
```
and recover 
```
git chekcout -- file.html
```

# reverting a commit 
see only the most recent commit entry
```
git log -n1
```
use git revert to undo your committed changes
```
git revert --no-edit HEAD
```
`--no-edit` flag tells Git we don't want to add a commit message for this action


# clone a repository (git clone)
```
git clone
```

# remote repositories (git pull)
- when git clones a repo, it creates a ref to the original repo that's called a _remote_ by using the name origin
- it sets up the cloned repo so that the clone will _pull_ or retrieve data from the _remote_, it is very efficient because it only copies the new commits and objects from the remote and then checks them into your working tree
- `git pull` is a combination of two simpler operations `git fetch` and `git merge`

# create pull requests (git request-pull)
you submit a pull request to ask owner of the repo to pull changes into the main code base 

```
git request-pull -p origin/main .
``` 

# complete pull request
- to complete the pull you have to set up a remote by using the `git remote` command 

# telling git which remote branch to track
```
git branch --set-upstream-to origin/main
```


# git stash and pop
- when you pull changes before committing your own
**Please commit your changes or stash them before you can merge.**
- git warning that the pull will overwrite your version of a file, because someone else modified the same file
- lets assume the file was `index.html` where both people made changes

1. use `git diff origin -- index.html`
2. check that changes don't overlap
3. `git stash` to save the state of the working tree and index by making a couple temporary commits (ie, saving your work while you do something else) without making a real commit or affecting your repository history
4. (you should stash or commit before pulling)
5. now it is safe to pull  (In fact, git stash is shorthand for git stash push. It's a lot like the stack where you put bills that you haven't gotten around to paying yet.) so run `git pull` and then `git stash pop`
6. Popping the stash merges the changes. If changes overlap, there might be a conflict.

# merge branches (git merge)

# Switch back to the main branch
```git checkout main```

# Merge my-feature branch into main
```git merge my-feature```

# addressing merge conflicts
few options:
- `git merge --abort` to restore the main branch to what it was before the merge , run `git pull` to get latest changes, create a new branch, make their changes and merge their breanch into the main branch
- `git reset --hard` to get back to where they were before they started the merge
- resolve conflict manually by using information git inserts into the affected files (preferred)
  - resolve manually in file, save file and then run following commands to commit the change
```
git add x
git commit -a -m "fix conflict"
git push 

# branches

## Navigating branches
-a shows all local and remote branches <br /> 
-v verbose shows commit subject line for each head <br /> 
```
git branch -av  
```
list all remote branches
```
git branch -r 
```
## creating branches
```
git checkout -b [your new branch name here] 
```
## checking out branches
```
git checkout -branch_name
```
where branch name is the name of the branch you want to checkout (get the name of the branch by listing all branches above)

## renaming local git branches
Before we begin, make sure you’ve selected the branch you want to rename. Run this command to do so:

```sql
git checkout old-name
```

Replace `old-name` with the name of the appropriate branch.

```sql
git branch -m **new**-name
```

Alternatively, you can rename a local branch by running the following commands:

```sql
git checkout master
```

Then, rename the branch by running:

```sql
git branch -m old-name **new**-name
```

Verify that the renaming was successful:

```sql
git branch -a
```

# basic actions

## add files / stage files for commit 
adds everything
```
git add . 
```
adds files that are not staged for commit (ignores untracked)
```
add -u
```
Though, your .gitignore should prevent the untracked (and ignored) files from being shown in status, added using git add etc. 

## commit files 
```
git commit -m "[insert commit message here]"
```

## undo the commit you just did 
```
git reset --soft HEAD~1
git restore --staged [filename]
```

# instead of .gitignore -- just exclude for yourself
```
cd .git
cd info

update it in that file 
```

# basic workflow examples
## simple commit and push upstream
Scenario:
1. you are working on a branch and made some changes
2. you want to save the changes to the remote branch
```
git add . or git add <specific_file_name>
git commit -m "insert commit message here"
git push -u origin <branch_name>
```

## VIM / text editor commands to complete a commit
[cmd - how do I complete a git commit? - Stack Overflow](https://stackoverflow.com/questions/39798997/how-do-i-complete-a-git-commit)

1. You can press the `i` key to go insert mode and type your commit message
2. `esc` when you're done
3. Then `ZZ` (twice, uppercase) to exit.

## merging in master to your branch (no conflicts)
Scenario:
1. you have been working on a branch
2. you do not have the latest master (someone else updated the master branch with changes since the last time you pulled from master)
3. you need to update master and merge it into your code before pushing your code
   
where <branch_name> is the branch you want to merge into master <br /> 
this flow assumes there are no conflicts with master <br /> 
```
git checkout master
git fetch
git pull
git checkout <branch_name> 
git merge master
git add .
git commit -m "insert comment here"
git push -u origin <branch_name>
```

[git - Merging changes from master into my branch - Stack Overflow](https://stackoverflow.com/questions/41045548/merging-changes-from-master-into-my-branch)

1. `git status`
2. `git checkout master`
3. `git pull` 
    1. “branch is behind by x commits”
4. if local changes need to be commit or stash
5. `git stash`
6. `git pull` to update local master
7. `git checkout local_branch`
8. `git merge master`

## merging in master to your branch (there are conflicts)
Scenario:
1. you have been working on a branch
2. you do not have the latest master (someone else updated the master branch with changes since the last time you pulled from master)
3. you need to update master and merge it into your code before pushing your code
   
where <branch_name> is the branch you want to merge into master <br /> 
this flow assumes there are no conflicts with master <br /> 
```
git checkout master
git fetch
git pull
git checkout <branch_name> 
git merge master
```
4. it will tell you have conflicts
5. open the conflicting files
6. fix the conflicts in the file, save it
7. commit your changes to finish the merge

```
git add .
git commit -m "something something fix conflicts"
git push -u origin <branch_name>
```
7. merge finished 

## Using git fetch to Fetch Changes Then Merge Using Commit Hash

fetch latest changes to repo <br /> 
check log to find hash for commit <br /> 
merge desired commit using the commit hash <br /> 
```
git fetch remote <branch_name>
git log
git merge <commit_hash>

```

# deleting a branch 
-D to force delete 
```
git branch -d <branch_name>
git branch -D <branch_name>
```
# Reversing git actions 

## Undo `git add` for uncommitted changes with:
```
git reset <file>

```
That will remove the file from the current index (the "about to be committed" list) without changing anything else.

## To unstage all changes for all files:

```
git reset
```


# delete a local branch

1. list all branches
    
    ```
    git branch -a
    ```
    
    It is not possible to delete a branch you are currently in and viewing. You will get an error. 
    
    Before deleting a local branch, 
    
2. switch to a branch **you do NOT want to delete**:

```
git checkout branch_name 
```

1. delete the branch using this command. 

```
git branch -d local_branch_name
```

If the branch contains unmerged changes and unpushed commits, the `-d` flag ill not allow local branch to be deleted

this is because commits are not seen by any other branches and git is protecting you from accidentally losing any commit data

if you still want to delete and are ABSOLUTELY SURE because there is no prompt asking you to confirm your actions

1. `-D` flag must be used

```
git branch -D local_branch_name
```

# delete a remote branch

Remote branches are separate from local branches. They are repositories hosted on a remote server that can be accessed there. Local branches are repositories on your local system. 

You don’t use `git branch`command that you use for local branches, instead you delete remote branches with the `git push` command. You’ll need to specify the name of the remote which is usually `origin`. 

1. list all remote branches
    
    ```yaml
    git branch -r
    ```
    
2. remote branches will show as g`remote/origin/branch1` and `remote/origin/branch2` 
    1. where remote name is `origin`
    2. and remote branch name is `branch1`
    
    ```yaml
    git push remote_name -d remote_branch_name
    ```
