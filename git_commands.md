
# Navigating branches
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

## checking branches

# basic workflow example
to commit your changes and push upstream 
```
git add . or git add <specific_file_name>
git commit -m "insert commit message here"
git push -u origin <branch_name>
``` 

# merging in master to your branch 
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

# deleting a branch 
-D to force delete 
```
git branch -d <branch_name>
git branch -D <branch_name>
```

# Using git fetch to Fetch Changes Then Merge Using Commit Hash

fetch latest changes to repo <br /> 
check log to find hash for commit <br /> 
merge desired commit using the commit hash <br /> 
```
git fetch remote <branch_name>
git log
git merge <commit_hash>

```
