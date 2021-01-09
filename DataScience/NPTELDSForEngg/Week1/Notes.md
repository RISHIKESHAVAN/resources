# __Data Science for Engineers__

## __Week 1__

### __1.1 Introduction to R__

__R__ is an open source programming language that is widely used asa statistical software and data analysis tool. __RStudio__ is an integrated development environment for R.

Components in R Studio:

+ __Console__ on the left: Where we can execute commands and see the results.
+ __Environment/History__ pane on the top right: Environment tab contains the variables that are generated in the workspace throughout the course of programming. History tab contains all the commands that are used till now from the beginning of usage of RStudio.
+ __Files/Plots/Packages/Viewer__ pane on the bottom right: Files tab shows the files and directories that are available in the default workspaceof R. The Plots tab, shows the plots that are generated during the course of programming. The Packages tab lists the packages that are already installed in the R Studio and it also allows to install new packages.The Help tab, is a most important one, where you can get help from the R Documentation on the functions that are in built in R. The Viewer tab, can be used to see the local web content that is generated using R or some other application.

Opening a script file adds a new __Scripts__ pane to the interface.

The _working directory_ can be set via two ways:

+ From console using the command: `setwd("<directorypath>")`
+ From the GUI: Files tab -> Change to the required dir -> More Options -> Set as working directory.

Running the script commands can be done in the following ways:

+ __Run__ runs the current/selected lines alone. It can be used to troubleshoot or debug the program when something is notbehaving according to your expectations.
+ __Source__ runs the entire script printing only the output which we want to print
+ __Source with Echo__ runs the entire script and prints the commands as well as the output

Lines can be commented using the "__#__" symbol.

The  console can be cleared using "__Ctrl + L__". Clearing the console will not remove the variables from the workspace.

A single variable can be cleared from the environment using the `rm(<variable name>)` command. All the variables can be cleared using `rm(list=ls())`. The variables can also be cleared via the GUI.

By default, the workspace information is never saved and will be lost whenever the RStudio is closed or restarted. However, the workspace info can be saved whenever required using the following methods:

| Command | Function |
| --- | --- |
| `save(a,file="sess1.Rdata")` | saves the single variable "a" to the specified file |
| `save(list=ls(all.names=TRUE),file="sess1.Rdata")` | saves the full workspace to the specifies file  |
| `save.image()` | shortcut to save the full workspace |
| `load(file="sess1.Rdata")` | loads the saved workspace  |

____

### __1.2 Variables and Data types__

Rules for naming variables:

+ Only alphanumeric characters, _ (underscoreand), . (period) are allowed.
+ Always start with an alphabet.

Predefined constants in R:
| Constant | Value |
| --- | --- |
| `pi` | 3.141593 |
| `letters` | "a","b","c",...  |
| `LETTERS` | "A","B","C",... |
| `month.name` | "January", "February",...  |
| `month.abb` | "Jan","Feb",... |

The basic data types in R:

+ __Logical__ : TRUE or FALSE
+ __Integer__ : Set of all integers, Z
+ __Numeric__ : Set of all real numbers
+ __Complex__ : Set of complex numbers
+ __Character__ : "a","b","c".."@","#","$","","*","1","2"..etc

Basic actions that can be performed on these data types:
| Command | Output |
| --- | --- |
| `typeof(object)` | Gives the data type of the object |
| `is.<data_type>(object)` | Returns TRUE or FALSE  |
| `as.<data_type>(object)` | Converts the object to another data type |
_Note: Not all conversions are possible and if attempted will return NA as output_

The basic objects in R:

__Vector__ :

+ Ordered collection of elements of same data type

 __List__ :

+ Ordered collection of objects created using the command `list()`
+ All components of the list can be named and the components can be accessed using their names as `<list>$<comp name>`
+ Components can also be accessed using indices. The top level components can be acccessed using `[[]]` and the inner elements of the components using `[]`
+ The list can also be modified by accessing the components and replacing them.
+ Two lists can also be concatenated using `c(list1,list2)`. Here, each component of the `list2` becomes a component of `list1`. To add a an entire list to a particular index in `list1`, it can be done as `list[[4]] = list2`

__Dataframe__ :

+ Generic object used to store tabular data. Created using the command `data.frame()`. Each parameter passed to this function will become the columns of the df and the names of the params will become the column names.
+ It is mandatory that all the values in a particular column are of the same data type.
+ Df can also be created by reading data from a file using the command `read.table(path="Path of file",sep)` (use '/' instead of '\\' in the path). The `sep` param is considered as space by default.
+ `df[r,c]` returns the element at the `r`th row and `c`th column. `r` and `c` can also be array of values like `1:3` or `c(1,3)`.
+ `subset()` function can be used to get a subset of the df. We can also provide conditions to be satisfied as `subset(df,Name=='Senthil'|Age>20)`
+ Editing a df is similar to editing a list - by direct assignment. `df[[2]][3] = 'R'` assigns the value 'R' to the element at 2nd column and 3rd row.
+ Dfs can also be edited on the GUI using the `edit()` command. Create an empty instance of the df by `df=data.frame()` and then use `df=edit(df)`.
+ Extra row can be added using `rbind()` and extra column can be added by `cbind()`.
+ There are several ways to delete rows and cols. `df[-3,-1]` - deletes the 3rd row and the 1st column. Conditional deletion is also possible.
+ When first creating the df, for columns that contain char data, R considers the entries in the columns as categories or factor levels. If you try to manipulate the existing data in those columns, it might throw an error stating that the new entry you are trying to add is not there in the current factors. To avoid that, add a param `stringsAsFactors = F` while creating the df.
+ __Identifier variables__ are variables with discrete data and __Measurement variables__ are ones with numeric data. Categorical and Date variables cannot be measurements.
+ __Recasting__ is the process of manipulating a data frame in terms of its variables. It is usually done in 2 steps: __Melt__ and __Cast__. The library `reshap2` has the necessary functions. Once the identifier and measurement variables are identified, we can proceed with the melt action using `melt(data, id.vars, measure.vars, variable.name = "variable", value.name = "value")`. This will reframe the entire df. After melting, the cast function `dcast(data, formula, value.var = <col with values>)` (specific for df) can be used to cast the df into the new structure.
+ Recasting can also be done in a single step using `recast(data, formula, id.var, measure.var)`
+ You can add a new variable to the df which is based on the existing variables using `mutate(df,new_var=<any function involving the old vars>)` from the `dplyr` library.
+ Combining two dataframes can also be done using the `dplyr` package. The commong syntax is `function(dataframe1, dataframe2, by=id.variable)`. The `id.variable` is an identifier variable that is common in both the dataframes and provided the identifiers for combining the 2 dataframes. The nature of combining depends on the `function` used. Some of the available functions to join the dataframes are: `left_join()`, `right_join()`, `inner_join()`, `full_join()`, `semi_join()`, `anti_join()`

____

### __1.3 Arithmetic, Logical and Matrix Operations__

Arithmetic operations in R:
| Symbol | Operation |
|---|---|
| =, <- | Assignment |
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| ^, ** | Exponent |
| %% | Remainder |
| %/% | Integer Division |

Hierarchy of operations:

| Order of Precedence | Operation |
|---|---|
| Bracket | () |
| Exponent | ^, ** |
| Division | / |
| Multiplication | * |
| Addition and Subtraction | +, - |

Various Logical operators are available in R.

__Matrices__ :

+ Rectangular arrangement of numbers in rows and columns.
+ A matrix can be created using `matrix(c(1,2,3,4,5,6,7,8,9),nrow=3.ncol=3,byrow=TRUE)`. By default, the `byrow` param is FALSE.
+ `matrix(3,m,n)` creates a matrix with `m` rows and `n` cols and all the elements as `3`. The function `diag(k,m,n)` creates a diagnol matrix with the specified elements for `k`. An identity matrix can be created by specifying `k` as 1.

__Matrix metrics__ :

+ `dim(A)` will return the size of the matrix
+ `nrow(A)` will return the number of rows
+ `ncol(A)` will return the number ofcolumns
+ `prod(dim(A))` or `length(A)` will return the number of elements

__Accessing, editing, deleting in elements in matrices__ :

+ Same convention as dataframes.
+ Strings can be assigned as names of rows and columns using: `rownames()` and `colnames()`.
+ `A[m,n]` - Array/value before “,” for accessing rows and Array/value before “," for accessing columns. A single column can be accessed be leaving the row part empty as `A[,n]`. Same can be applied for accessing entire rows.
+ Using ‘-’ for removes rows/columns (i.e) `A[,-2]` returns the entire matrix without only the 2nd column. Same for rows.
+ `A[c(1,3),c(2,4)]` - selects the 1st row, 3rd row and 2nd col, 4th col. `A[1:3,2:4]` - selects 1st to 3rd row (inclusive) and 2nd to 4th col (inclusive)

__Matrix Concatenation__:

+ Refers to merging of a row or column to a matrix
+ `rbind()` concatenates a row to the matrix and `cbind()` concatenates a column to the matrix
+ Consistency of the dimensions between the matrix and the vector should be checked before concatenation.

__Matrix Algebra__:
| Symbol | Operation |
|---|---|
| A+B | Element wise addition |
| A-B | Element wise subtraction |
| A*B | Element wise multiplication |
| A%*%B | Normal multiplication |
| A/B | Element wise division (NOT inverse of matrix) |

____
