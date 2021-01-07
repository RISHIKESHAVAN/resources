# Data Science for Engineers

## Week 1

### 1.1 Introduction to R

__R__ is an open source programming language that is widely used asa statistical software and data analysis tool. __RStudio__ is an integrated development environment for R.

Components in R Studio:

+ __Console__ on the left: Where we can execute commands and see the results.
+ __Environment/History__ pane on the top right: Environment tab contains the variables that are generated in the workspace throughout the course of programming. History tab contains all the commands that are used till now from the beginning of usage of RStudio.
+ __Files/Plots/Packages/Viewer__ pane on the bottom right: Files tab shows the files and directories that are available in the default workspaceof R. The Plots tab, shows the plots that are generated during the course of programming. The Packages tab lists the packages that are already installed in the R Studio and it also allows to install new packages.The Help tab, is a most important one, where you can get help from the R Documentation on the functions that are in built in R. The Viewer tab, can be used to see the local web content that is generated using R or some other application.

Opening a script file adds a new __Scripts__ pane to the interface.

The _working directory_ can be set via two ways:

+ From console using the command: `setwd("\<directorypath>")`
+ From the GUI: Files tab -> Change to the required dir -> More Options -> Set as working directory.

Running the script commands can be done in the following ways:

+ __Run__ runs the current/selected lines alone. It can be used to troubleshoot or debug the program when something is notbehaving according to your expectations.
+ __Source__ runs the entire script printing only the output which we want to print
+ __Source with Echo__ runs the entire script and prints the commands as well as the output

Lines can be commented using the "__#__" symbol.

The  console can be cleared using "__Ctrl + L__". Clearing the console will not remove the variables from the workspace.

A single variable can be cleared from the environment using the `rm(\<variable name>)` command. All the variables can be cleared using `rm(list=ls())`. The variables can also be cleared via the GUI.

By default, the workspace information is never saved and will be lost whenever the RStudio is closed or restarted. However, the workspace info can be saved whenever required using the following methods:

+ `save(a,file="sess1.Rdata")` : saves the single variable "a" to the specified file
+ `save(list=ls(all.names=TRUE),file="sess1.Rdata")` : saves the full workspace to the specifies file
+ `save.image()` : shortcut to save the full workspace
+ `load(file="sess1.Rdata")` : loads the saved workspace

____

### 1.2 Variables and Data types

Rules for naming variables:

+ Only alphanumeric characters, _ (underscoreand), . (period) are allowed.
+ Always start with an alphabet.

Predefined constants in R:

+ `pi` - 3.141593
+ `letters` - "a","b","c",...
+ `LETTERS` - "A","B","C",...
+ `month.name` - "January", "February",...
+ `month.abb` - "Jan","Feb",...

The basic data types in R:

| Basic Data Types | Values |
| --- | --- |
| _Logical_ | TRUE or FALSE |
| _Integer_ | Set of all integers, Z |
| _Numeric_ | Set of all real numbers |
| _Complex_ | Set of complex numbers |
| _Character_ | "a","b","c".."@","#","$","", "*","1","2"..etc |
