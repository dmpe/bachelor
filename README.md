Bachelor's Thesis: The Attractiveness Index of Global Economies
========

This repo contains **the source code**, which I have used for my bachelor's thesis when creating my own composite indicator: [*The Attractiveness Index of Global Economies*](https://dmpe.github.io/PapersAndArticles/). 

My thesis can be read here <https://dmpe.github.io/PapersAndArticles/> and please feel free to contact me if needed. Any corrections or suggestions may (and probably even will!) be done.

My website <https://indestat.wordpress.com/contact-me>.

As a small exercise (before I even started with my work) I have created <http://rpubs.com/F789GH/SingaporesEducation> (BTW. you will need to look <https://gist.github.com/dmpe/b8c3f74d1e937d90b20f> for the code as the link inside is wrong).

## (rJava) Installation

To install necessary packages, go to `0_Util\Install_packages.R` and read corresponding (and another) `Read Me` file.

The installation process of rJava (on Ubuntu) is quite pathetic. So take a long breath and submit problems to <https://github.com/s-u/rJava> (as of 2015, he seems to have abandoned it). To make `rJava` work, use Google and stackoverflow. 

Always install official java 8 from oracle and (less) *official* "openjdk-8". Don't forget to run R CMD javareconf (-e) too! Maybe this will also help <http://stackoverflow.com/a/21504335>

Or, at last use some other packages too: <https://github.com/hadley/readxl>. 

**Then**

Only if you are sure that `rJava` works (e.g. you can load it without getting any errors), only then you can execute first 10 lines of the code in the `6_UnserSensi\BackToDetails.R`. This is basically the starting point to reproduce any data frame. 

## Citation

<u>To quote me, please consider using</u>:

Dmitrij Petrov (Jun. 2015), *The Attractiveness Index of Global Economies*, Bachelor's Thesis, Reutlingen University

**Bibtext**
```
@mastersthesis {petrov15,
    type    = {Bachelor's Thesis},
    author  = {Dmitrij Petrov},
    title   = {The Attractiveness Index of Global Economies},
    school  = {Reutlingen University},
    year    = {2015},
    url     = {https://dmpe.github.io/PapersAndArticles/},
    month   = {6}
}
```

## License

Full copyright on text! No exceptions will be ever made. 

Partial on code, which is under Apache License 2.0

In the case you still have questions on the usage, contact me please. Nevertheless, you **must** always quote me!

