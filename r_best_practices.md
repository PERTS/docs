## Import scripts as modules and prefer importing packages over to `library()`

### Rationale

`source()` is annoying because

* It's hard to trace where a given variable in your script is defined because just looking at the `source()` line doesn't tell you what's in the file you sourced. Consider a script `foo.R` that defines the variable `bar`. The line `source('foo.R')` doesn't leap out as the reason why `bar` is defined.
* Namespace collisions; if something you source defines something with the same name that's already in your environment, it gets overwritten; this becomes worse when files you `source()` call `library()`, because all those package functions also carry over.
* It's unconventional; almost all modern languages have the ability to import isolated environments/scopes/closures.

`library()` is annoying because

* It obscures the fact that all installed packages are already available (you don't need to call `library()` to use them! Restart R and run `dplyr::summarise`; if it's installed, you'll see it).
* It's hard to trace or discover where a given variable in your script is defined because functions defined in packages have no obvious naming pattern that shows what package they came from, you have to just be familiar with the contents of each package being called with `library()`.
* Namespace collisions, as above.

### Best practice

So, try to use `modules` which give us explicit imports, and forces package namespacing.

* Importing a script with `use()` like so: `sql <- modules::use('sql.R')` does tow things
    - makes it explicit where all sql functions came from, and
    - makes it easier to avoid/debug namespace collisions i.e. there no hidden side-effects on your environment.
* Code inside scripts which are imported via `modules::use` must explicitly declare the packages they're using; calling `library()` will raise an error. Code must either use double colon syntax for each package function, e.g. `dplyr::summarise()`, or use modules' equivalent of `library()`, which looks like `modules::import('dplyr', 'summarise')`. In both cases it can't affect the environments of calling scripts.

While not preferred, importing whole packages at once e.g. `modules::import('dplyr')` can make adapting old code for use in modules easier. This will generate masking warning messages, and can be slower. It also breaks the discoverability of how functions are related to their packages; just like calling `library()`, no one can figure out that `summarise` comes from `dplyr` just by reading the code.

### Akward exceptions

**What if the package isn't installed?**

Projects should declare the packages they depend on in a `package.json` file, and then install them all with `modules::depend()` in top-level code. Gymnast can help with this:

```
installer <- modules::use('gymnast/R/installer.R')
installer$install_project_dependencies()
```

**What if the location of the file to import is hard to determine, i.e. you don't know your working directory?**

This is why packages exist, because they can be looked up / installed from any CRAN mirror. If a function is in a package, you always know where to get it. We may build packages in the future, but compiling and publishing them is a hassle, and it's much easier to just use `*.R` files as modules.

In general this problem can be avoided by always keeping your working directory at the root of the relevant repository. Then all files that need to be imported can be placed in a subdirectory like `modules` and imported with `modules::use('modules/something.R')`.

### How do these all work, exactly?

`source('helpers.R')`

Naively executes all contained code in the current environment. Results in all functions available directly, e.g. `helper_function()`. If the sourced file executes code (rather than just defining variables/functions), this will execute that code as well.

`library(dplyr)`

Assigns all functions within the package to the current environment. Then functions can be called directly, e.g. `mutate()`.

`ensure_packages(c('dplyr'))`

Calls `install.packages()`, if needed, with nice defaults.

`app <- modules::use('app.R')`

Execute code in the script in an isolated environment, then returns that environment as a list. Code inside such scripts needs to be explicit about package use, either through `::` or `modules::import()`.

`modules::use('app.R', attach = TRUE)`

Does the same as above, but then assigns the resulting list to the current environment. Functions from that list can be called directly. To be avoided for the same reasons as `library()`.

`modules::import('dplyr')`

Equivalent of `library()` for code inside modules; assigns all package functions to the current environment. Useful for quickly adapting old code that doesn't use `::`, but otherwise to be avoided for the same reasons as `library()`.

`modules::import('dplyr', 'summarise')`

Assigns only the requested package function to the environment. Useful if you know you only want a small part of a large package. Also it's nicely explicit about what variable is being defined.

## Prefer pure operations

Pure functions have no side-effects, they only return a value, which depends entirely on the inputs. Pure functions are great because they're easy to understand, debug, re-use, and deploy in various contexts (like App Engine). Most of the code we write should be in the form of pure functions. Of course side-effects like writing to disk are inevitable if you want to get anything done, but they can be collected at the "edges" of your code, e.g. only at the beginning at the end of a given script, or wrapped within their own functions. In either case, the pure and non-pure code can easily be separated.

The following operations make code non-pure and should be **avoided** in the bulk of code:

* Setting global `options()`
* Accessing or writing to objects outside a function
* Writing or reading from the file system
* Unix commands e.g. with `system()`
* Network traffic:
  - Calling `source()` on a URL
  - using packages like `httr` or `RCurl`
  - reading from google sheets
  - connecting to databases
* Importing code from another file from within a function. Instead, importing other code should happen in the global environment of the primary script.

## Fail gracefully for zero-length structures

Avoid looping over ranges that always start with 1, because they fail when the number of iterations is zero:

```
# Fails when length(x) is zero:
for (i in 1:length(x)) { ... }
```

Prefer looping over the values of the structure itself, or use `sequence` because `sequence(0)` is `integer(0)` and results in the loop simply not executing.

```
# Loop over values:
for (y in x) { ... }

# Or allow for zero length in indexes:
for (i in sequence(length(x))) { ... }
```

## Prefer immutable data

Avoid overwriting objects in the environment, which often happens when "building up" data.

```
# Bad practice:
x <- data.frame(...)
x <- dplyr::filter(x, ...)
x <- merge(x, ...)
```

This makes scripts difficult to debug because the value of `x` varies depending on exactly where in the script you are accessing code. If you run the code to the end, but then need to investigate what the value of `x` was halfway through, there's no obvious strategy other than to start over.

Prefer giving objects distinct, descriptive names and make new ones rather that overwriting old ones.

```
# Good practice:
default_responses <- data.frame(...)
last_week_responses <- dplyr::filter(default_responses, ...)
response_class_assoc <- merge(last_week_responses, ...)
```

Note that piping can replace existing "built up" code without overwriting objects because only the final object is written to the environment:

```
# Build up data with pipes:
y <- x %>%
  addSomeData() %>%
  addMoreData()
```

One downside to using distinct names for every object is that environments can start to use a lot of memory (R copies objects with every assignment). However this is only a problem if many lines of complex code are written in the same envionment, which is also to be avoided, see [Prefer functions](#prefer-functions).

## Prefer functions

Most code should be inside functions and called from elsewhere. This keeps any given environment small, which keeps computer memory needs small and programmer working memory needs small. It also promotes reusability.

**Even when there's little chance a given chunk of code will be reused** exactly as-is, it's much easier to analyze, maintain, and read code that is broken up into functions. Critically, functions are explicit about what information they depend on via their arguments, so it is _much_ easier to understand when a function needs to change or can be safely left alone, or when it can be removed.

At the risk of overemphasis, code should _not_ be written in huge, flat scripts where (for instance) code on line 1800 can reference variables modified on lines 295 and 1342, because maintaining and modifying it is enormously time consuming. Code reviewers should insist that changes which extend the length of a script significantly be broken up into functions.

```
# Good practice:
data <- importSomeData()
descriptive_name1 <- complicatedOperationOne(data)
descriptive_name2 <- complicatedOperationTwo(data)
result <- complicatedOperationThree(
    descriptive_name1,
    descriptive_name2
)
writeResultSomewhereUseful(result)
# End of script! So short!
```