
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