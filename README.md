## Cleaning the data

Making sure ID is unique

```
$ cut -f 1 -d "," data/nodes.csv | sort -u | wc -l
3146

$ wc -l data/nodes.csv
3146
```
