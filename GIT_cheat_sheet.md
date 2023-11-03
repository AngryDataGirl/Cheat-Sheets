# terminology

- **Working tree:** The set of nested directories and files that contain the project that's being worked on.
- **Repository (repo):** The directory, located at the top level of a working tree, where Git keeps all the history and metadata for a project. Repositories are almost always referred to as repos. A bare repository is one that isn't part of a working tree; it's used for sharing or backup. A bare repo is usually a directory with a name that ends in .git—for example, project.git.
- **Hash:** A number produced by a hash function that represents the contents of a file or another object as a fixed number of digits. Git uses hashes that are 160 bits long. One advantage to using hashes is that Git can tell whether a file has changed by hashing its contents and comparing the result to the previous hash. If the file time-and-date stamp is changed, but the file hash isn’t changed, Git knows the file contents aren’t changed.
- **Object:** A Git repo contains four types of objects, each uniquely identified by an SHA-1 hash. A blob object contains an ordinary file. A tree object represents a directory; it contains names, hashes, and permissions. A commit object represents a specific version of the working tree. A tag is a name attached to a commit.
- **Commit:** When used as a verb, commit means to make a commit object. This action takes its name from commits to a database. It means you are committing the changes you have made so that others can eventually see them, too.
- **Branch:** A branch is a named series of linked commits. The most recent commit on a branch is called the head. The default branch, which is created when you initialize a repository, is called main, often named master in Git. The head of the current branch is named HEAD. Branches are an incredibly useful feature of Git because they allow developers to work independently (or together) in branches and later merge their changes into the default branch.
- **Remote:** A remote is a named reference to another Git repository. When you create a repo, Git creates a remote named origin that is the default remote for push and pull operations.
- **Commands, subcommands, and options:** Git operations are performed by using commands like git push and git pull. git is the command, and push or pull is the subcommand. The subcommand specifies the operation you want Git to perform. Commands frequently are accompanied by options, which use hyphens (-) or double hyphens (--). For example, git reset --hard.

# config 

```
git config --global user.name "<USER_NAME>"
git config --global user.email "<USER_EMAIL>"
git config --list
user.name=User Name
user.email=user-name@contoso.com
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
