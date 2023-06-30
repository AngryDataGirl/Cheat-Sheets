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
