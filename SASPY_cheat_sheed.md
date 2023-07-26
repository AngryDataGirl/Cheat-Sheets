# Saspy
[Official Documentation](https://sassoftware.github.io/saspy/)

## Installation

```python
# regular install
pip install saspy

# release:
pip install http://github.com/sassoftware/saspy/releases/saspy-X.X.X.tar.gz

# or, for a given branch (put the name of the branch after @)
pip install git+https://git@github.com/sassoftware/saspy.git@branchname

#The best way to update and existing deployment to the latest SASPy version is to simply uninstall and then install
pip uninstall -y saspy
pip install saspy
```

## Commands

### import
```python
import saspy
import pandas as pd
```

### start a SAS session
```python
sas = saspy.SASsession(cfgname='default')
```
