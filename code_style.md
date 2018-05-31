# Code Style Conventions

To make our code mutually more readable, let's follow some style conventions. Let's also keep the rules few and simple.


## All Languages

### Indent blocks

In general this means increase your indent by one level after every open curly bracket, i.e. function bodies, for loops, if blocks, etc.

### Indent with spaces, not tabs

This way if different text editors assign different width to tabs, our code doesn't get messed up.

### 2-space indentations

With the exception of Python, which uses 4 spaces.

### No Trailing Whitespace

Don't leave random spaces trailing at the end of a line. The Sublime user setting "trim_trailing_white_space_on_save" will handle them for you. Or use a quick regex to replace them all: ` +$`

### Spaces

Put spaces around operators (like plus and equals), and after commas and colons.

    answer = 5 + max(6, 7)
    eat = {spam: 'alot'}

### Maximum 79-character lines

When reading code on github.com, or if your text editor doesn't always wrap lines, keeping a hard-wrapped width makes things more readable (one important exception here is Markdown documents, including RMarkdown, where soft-wrapped body text is the norm). If you've got a long line, try one of the line breaking strategies below.

### Indentation after line breaks

Put line breaks after commas or open brackets, using one of two methods.

**Indentation Method #1: after open brackets**

    function () {
        my_variable  # one four-space indent after line break
    }  # close bracket goes on new line

    result = long_function_call(
        long_argument_one, long_argument_two, long_argument_three,
        long_argument_four
    )

    list_of_stuff = [
        'thing1',
        'thing2',
        'thing3'
    ]

**Indentation Method #2: within brackets**

    result = do_stuff(long_argument_one, long_argument_two,
                      long_argument_three)  # indent to the open bracket
    # closing bracket does not go on a new line

### Case

Unless otherwise specified, the default case for all files and code is snake case i.e. underscore case. This holds for R, Python, and most file and folder names.

    # Files
    like_this.html
    py_module.py

    # Python
    import py_module
    def accomplish_task():

    # R
    cleaned_df <- qc.clean_qualtrics(df)  # R

JavaScript uses camel case, including in file names.

    coolModule.js
    componentTemplate.html

    import coolModule from './coolModule';

    const likeThis = 5;

CSS and HTML use dash case, which includes tags, element ids, class names, and attributes. User-facing URLs, like front end application routes and short links, are also in dash case.

    .like-this {
      font-weight: bold;
    }

    <my-tag id="the-tag" class="like-this" ng-model="this"></my-tag>

    perts.net/google-sees-this-url
    pertsapp.org/users/5/account-settings

One exception to the dash case rule is JSX in React, which has strong community conventions to treat everything ike JavaScript variables, so they are in camel case:

    <CoolComponent className="CleverStyles" />

### Comments

Use single-line comment syntax ( // or # ) rather than multi-line comment syntax ( /* … */ ) whenever possible. More commenting is better. Comments should be used to

* Explain the high-level intent of the code
* Note any tricky gotchas or things to be careful of
* Links to where you learned a certain technique or read some crucial documentation
* In the case of functions:
  - What the function does
  - What the arguments can be and what they do
  - What the function returns
  - Whether it throws errors
  - Example(s) of calling the function

**Commenting-out code**

Comments should be reserved for human-language annotation (actual comments), not "turning off" programming code, unless one is actively testing. Delete code that should be turned off before committing; it's always recoverable via version control.

**Full line comments**

Start at the same level of indentation as surrounding code. Put one space after the comment character. Write with normal sentence grammar, spelling, and punctuation.

    function (x) {
        // Takes any integer and doubles it.
        return x * 2
    }

**In-line comments**

Limited to very short comments. Put two spaces between the end of the code and the comment character, and one more space after it. Be as terse as you like.

    function (x) {
        return parseInt(x, 10) * 2;  // parseInt() needs radix arg
    }


## Javascript

For maximum explicitness, you should install [jshint][1] in your code editor and give it [these][2] settings. If for some reason you can't, you can run your code through [jslint.com](jslint.com).

[1]: http://jshint.com/docs/ "JSHint docs"
[2]: https://gist.github.com/cmacrander/b4122329b4699f2a6bd6 "need to move this jshint config into the repo"

### Variable declarations

Default to `const` for variables which won't be reassigned. Note that `const` doesn't mean the value can't change, just that you can't put it on the left hand side of an assignment.

Otherwise use `var` for variables that belong to a whole function scope and `let` for variables meant to live in a block scope .

    function foo(x) {
      const y = 5;  // never reassigned
      var counter = 0;  // gets reassigned
      if (y > 0) {
        let z = true;  // only lives in the block
        /* do stuff */
      }
      for (let i = 0; i < x; i += 1) {
        counter += 1;
        /* do stuff */
      }
    }

### Arrow Functions

Always use parentheses around argument sets, even though it's sometimes optional.

    () => 5
    (x) => 2 * x
    (x, y) => x + y

Use them sparingly, reserving them for cases where functions are already extremely concise, or when it's inconvenient for the function to have its own `this` (b/c arrow functions don't have them).

Reasons to avoid them include: operator precedence complications, complex rules about implicit return, inability to give a name to the function which makes debugging difficult.


## Python

Follow [PEP 8][3], ideally by installing a style checker, like SublimeLinter.

Functions and classes should have docstrings per [PEP 257][4].

[3]: https://www.python.org/dev/peps/pep-0008/ "PEP 8"
[4]: https://www.python.org/dev/peps/pep-0257/ "PEP 257"


## R

Follow [Hadley Wickham's style guide][5], which is generally the same as the rules above. No spaces within brackets, but definitely spacing around operators and after commas. The dollar sign and double colons are exceptions as they are considered part of the variable name rather than operators in this sense.

    # space around <-, %in%, after comma, not $
    d <- d[d$include %in% TRUE, ]

    # no spaces around the double colon or parens
    jsonlite::fromJSON(my_string)

Functions should be documented within the body of the function, and otherwise follow Wickham's [roxygen format][6].

[5]: http://adv-r.had.co.nz/Style.html "Wickham's Style Guide For R"
[6]:http://r-pkgs.had.co.nz/man.html#man-functions "ROxygen Documentation Format"

### String concatenation and wrapping

This is hard in R, considering how verbose paste() is. If you source util.R, you can use the %+% operator to concatenate strings.

    "Simple is as " %+% simple_str %+% " does."

    stop("Here's a long message that shouldn't go too long, " %+%
         "so I use the infix operator!")

### Piping

When piping, the first indent comes after the first pipe. After the first indent, additional indents occur after open-parentheses.

    new_df <- old_df %>%
        group_by(
            group1,
            group2
        ) %>%
        summarise(
            mean = mean(dv1),
            n = n()
        )

Alternatively, an open parenthesis need not be followed by a new line, if the contents of the parentheses are brief

    new_df <- old_df %>%
        group_by(group1, group2) %>%
        summarise(mean = mean(dv1), n = n())


## Setting up RStudio

Everyone should set these options to make it easier to follow conventions.

In Options > Code > Editing, select:

* Insert spaces for tab (2)
* Uncheck soft-wrap R source files
* Strip trailing horizontal whitespace when saving

In Options > Code > Display, select:

* Show line numbers
* Show margin (79)

In Options > Code > Diagnostics, select:

* Warn if variable is defined but not used
* Provide R style diagnostics (e.g. whitespace)

### Organizing R Functions

Where does the function go?

* Gymnast
  - Totally agnostic
* perts_analyses/common
  - Specific to PERTS architecture
  - Agnostic to specific analyses
* project-specific helper file
  - Want to reuse something over several .Rmd files
  - Still specific to one study/analysis
* Within the .Rmd
  - Dedicated header/section "Helper Functions"
    + Any function you'll use several times within the .Rmd
  - define-and-use
    + just want to encapsulate variables or make things look pretty/readable
