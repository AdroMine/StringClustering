# Readme

You have probably completed the Reproducible research final project, where we were supposed to analyse the U.S. National Oceanic and Atmospheric Administration's [(NOAA)](https://www.ncdc.noaa.gov/stormevents/details.jsp) storm database. The data can be found [here](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2), and my analysis [here.](https://adromine.github.io/US-Storm-database-analysis/)   

Now one problem one faces when analysing this database is to group the different storm types together. NOAA has officially recognised 48 different event types, but due to data entry errors, and possibly other reasons, there are more than 900 unique events! Naturally these need to be grouped together into smaller and more manageable groups, and that is where text clustering comes in, a technique used in data mining to cluster similar strings together.   

This app showcases various methods of string clustering, using the storm types from the above mentioned database.   

* You can select the algorithm which will be used to group strings together based on similarity, with different algorithms having different criteria for makes the strings similar. 
* You can then select the number of clusters to group the strings into. 
* Then finally, out of the created clusters, look at one cluster at a time in the table.  

By default, the app uses the Jaro distance algorithm (which seems to give the best result for this example) to group the strings into 80 groups, and then displays the strings grouped together in the first cluster.  


### Algorithms and their brief explanation

* The **Jaro distance** (method='jw', p=0), is a number between 0 (exact match) and 1 (completely dissimilar) measuring dissimilarity between strings. It is defined to be 0 when both strings have length 0, and 1 when there are no character matches between a and b. Otherwise, the Jaro distance is defined as 1-(1/3)(w_1m/|a| + w_2m/|b| + w_3(m-t)/m). Here,|a| indicates the number of characters in a, m is the number of character matches and t the number of transpositions of matching characters. The w_i are weights associated with the characters in a, characters in b and with transpositions. A character c of a matches a character from b when c occurs in b, and the index of c in a differs less than \max(|a|,|b|)/2 -1 (where we use integer division) from the index of c in b. Two matching characters are transposed when they are matched but they occur in different order in string a and b.   



* The **Jaro-Winkler distance** (method=jw, 0\<p\<=0.25) adds a correction term to the Jaro-distance. It is defined as d - l\cdot p\cdot d, where d is the Jaro-distance. Here, l is obtained by counting, from the start of the input strings, after how many characters the first character mismatch between the two strings occurs, with a maximum of four. The factor p is a penalty factor, which in the work of Winkler is often chosen 0.1.   


* The **Levenshtein distance** (method='lv') counts the number of deletions, insertions and substitutions necessary to turn b into a. This method is equivalent to R's native adist function.   


* The **full Damerau-Levensthein distance** (method='dl') is like the optimal string alignment distance except that it allows for multiple edits on substrings.   



* A **q-gram** (method='qgram') is a subsequence of q consecutive characters of a string. If x (y) is the vector of counts of q-gram occurrences in a (b), the q-gram distance is given by the sum over the absolute differences |x_i-y_i|. The computation is aborted when q is is larger than the length of any of the strings. In that case Inf is returned.   



* The **Hamming distance** (method='hamming') counts the number of character substitutions that turns b into a. If a and b have different number of characters the distance is Inf.   



* The **longest common substring** (method='lcs') is defined as the longest string that can be obtained by pairing characters from a and b while keeping the order of characters intact. The lcs-distance is defined as the number of unpaired characters. The distance is equivalent to the edit distance allowing only deletions and insertions, each with weight one.   



* The **Optimal String Alignment distance** (method='osa') is like the Levenshtein distance but also allows transposition of adjacent characters. Here, each substring may be edited only once. (For example, a character cannot be transposed twice to move it forward in the string).   


* For the **soundex** distance (method='soundex'), strings are translated to a soundex code (see phonetic for a specification). The distance between strings is 0 when they have the same soundex code, otherwise 1. Note that soundex recoding is only meaningful for characters in the ranges a-z and A-Z. 