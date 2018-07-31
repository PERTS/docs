# Conventions for importing scripts and packages in R

## Rationale

`source()` is annoying because

* It's hard to trace where a given variable in your script is defined because just looking at the `source()` line doesn't tell you what's in the file you sourced. Consider a script `foo.R` that defines the variable `bar`. The line `source('foo.R')` doesn't leap out as the reason why `bar` is defined.
* Namespace collisions; if something you source defines something with the same name that's already in your environment, it gets overwritten; this becomes worse when files you `source()` call `library()`, because all those package functions also carry over.
* It's unconventional; almost all modern languages have the ability to import isolated environments/scopes/closures.

`library()` is annoying because

* It obscures the fact that all installed packages are already available (you don't need to call `library()` to use them! Restart R and run `dplyr::summarise`; if it's installed, you'll see it).
* It's hard to trace where a given variable in your script is defined because functions defined in packages have no obvious naming pattern that shows what package they came from, you have to just be familiar with the contents of each package being called with `library()`.
* Namespace collisions, as above.

## Best practice

So, try to use `modules` which give us explicit imports, and forces package namespacing.

* Importing a script with `use()` like so: `sql <- modules::use('sql.R')` 1) makes it explicit where all sql functions came from, and 2) makes it easier to avoid/debug namespace collisions i.e. there no hidden side-effects on your environment.
* Code inside scripts which are imported via `modules::use` must explicitly declare the packages they're using, either with double colon syntax on each package function call, or with `modules::import("my_package")`. In both cases it can't affect the environments of calling scripts. Using the `::` is preferred for new code. Using `import()` can make adapting old code for use in modules easier.

## Akward exceptions

### What if the package isn't installed?

This is why we're starting to use `ensure_packages()`.

### What if the location of the file to import is hard to determine, i.e. you don't know your working directory?

This is why packages exist, because they can be looked up / installed from any CRAN mirror. If a function is in a package, you always know where to get it.

For little script files, this is harder, but is a great use case for loading gymnast code from github; we always know where that is.

And _that_ is a good reason not to run `gymnast_install()` directly within `util.R` because it forces anyone using any gymnast code to install all those packages.

## How do these all work, exactly?

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
