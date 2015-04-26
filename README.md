# WeatherPredictor
[![Build Status](https://travis-ci.org/zelfrontial/WeatherPredictor.svg?branch=master)](https://travis-ci.org/zelfrontial/WeatherPredictor)
Predict Weathers in Melbourne

#Read This
https://guides.github.com/introduction/flow/

#Do this for basics
https://try.github.io/levels/1/challenges/1

#Read and understand this before starting to collaborate
http://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging


#Git setup tutorial.
'''
URL = https://github.com/zelfrontial/WeatherPredictor.git
'''

#First setup
In your designated folder in cmd/bash
'''
git init
git remote add origin URL
'''

confirm it..
'''
denisthamrim$ git remote -v
origin	https://github.com/zelfrontial/WeatherPredictor.git (fetch)
origin	https://github.com/zelfrontial/WeatherPredictor.git (push)
'''
git pull URL

always, check for git status

Done (:

#Part 2.
To get the latest changes,
'''
git pull origin master 
'''
-get the latest master branch from the url.

to create branch
'''
git branch "branch name"
'''

go to branch
'''
git checkout "branch name"
'''

to add file to git
(add everything to git)
'''
git add . 
'''

to save changes
'''
git commit -m "MESSAGE"
'''

to submit changes
'''
git push origin BRANCHNAME
'''
do not 
git push origin master !!! push to branch and ask for merge request.





