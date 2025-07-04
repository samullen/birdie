## Setup

Birdie was built on the latest versions of Ruby (3.4.1) and Rails (8.0.2).
Having those installed is a prereq. It's assumed the reviewers know how to
install both as well as getting a new Rails project up and running: installing
gems, setting up the DB, and running migrations.

### Installing the sample data

Running `rails db:seed` is all that's needed to load the sample data set
provided in the challenge. Because the challenge is focused more on architecture
and retrieving data, loading the data was brute forced, so it takes a moment
(less than 2 minutes on my machine) to load the data.

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

## Reasoning

### Solution

The key term in the `PROMPT.md` file was "adjacency list," even if at first I
was thinking "recursion". I would have used a "recursive" query, but then I
remembered a book I reviewed for PragProg: SQL Antipatterns, Volume 1. In the
section on adjacency lists, it provided several solutions to this sort of
problem. I went with a "closure table," because I thought it would provide the
most responsive queries at the expense of extra storage.

Closure tables should scale fine with Postgres even given the possibility of
billions of records, with the exception of root nodes having many descendants on
average. In that case, maybe a graph database would work better.

### Loading the data

As mentioned above, there is a `db/seeds.rb` file. To avoid foreign key
constraints, I made sure to sort the data by the parent ID if available.

### Testing

I did not use TDD, because I was more worried about figuring out the answer than
following my normal practice. I should have, because I think all the manual
testing I did slowed me down. :facepalm:

I added tests after the fact. They can be run with `rails test`

## What I didn't do

- create a nice frontend for this. It's just an API.
- Remove the default `up` route, in case reviewers wanted to make sure the app
  was runnable
- Use AI for much beyond code completion. I probably should have, but it was an
  interesting problem and I enjoyed working on it old school.
  - Not entirely true, I almost added bird names and I had AI generate prefixes
    and species lists which, when combined, would have created all the necessary
    bird names.

## Assumptions

- Parent id is always less than child id
