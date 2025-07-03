## Setup

Birdie was built on the latest versions of Ruby (3.4.1) and Rails (8.0.2).
Having those installed is a prereq. It's assumed the reviewers know how to
install both as well as getting a new Rails project up and running: installing
gems, setting up the DB, and running migrations.

### Installing the sample data

Running `rails db:seed` is all that is needed to load the sample data set
provided in the challenge. Because the challenge is focused more on architecture
and retrieving data, loading the data was brute forced, so it takes a moment to
load the data.

# Process

## Cleaning the data

I wanted to make sure the data I was dealing with made sense. I ran a couple
unix commands to make sure of that.

```
$ cut -f 1 -d "," data/nodes.csv | sort -u | wc -l
3146

$ wc -l data/nodes.csv
3146
```

## Assumptions

- Parent id is always less than child id

## ToDo

- [X] Sort the data
- [X] Data loader that looks up ancestors and descendants
- [X] validate data
- [ ] re-validate data
