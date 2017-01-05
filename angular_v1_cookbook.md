# PERTS Angular version 1.x Cookbook

## Communication

Between controllers, directives, and components. Methods of sending data are organized by parent-child relationship. Anything that generates a nested scope, like a component written in the markup governed by a controller, is a child.

### Parent provides data to Child

* Non-isolated heirarchical scopes via prototype inheritance
  - Avoid. Useful when working with simple directives directly in markup, like `ngRepeat`. But placing some variable on a `$scope` and then depending on it in some other file is brittle and difficult to document.
* Isolate scope binding:
  - `=` i.e. two-way binding. Avoid. This allows the child to modify the data in ways the parent might not expect.
  - `@` i.e. literal parsing. Preferred for primitive hard-coded inputs, like strings.
  - `&` i.e. expression parsing. Preferred for API-like interaction between directives.
  - `<` i.e. one-way binding. Preferred for non-primitive or dynamic inputs. Prevents the child from altering parent data.
* Service setter/getter.
  - Preferred for OOP-style data; if multiple components need to work with widgets, they can get and set widgets via a `Widget` service.
* `$broadcast` with value
  - Avoid. Event publish/subscribe patterns are highly flexible (and so sometimes are the quckest solution) but by the same token allow for spaghetti code.

### Child provides data to Parent

* Service setter/getter
  - Preferred for OOP-style data (see above)
* Required Parent controller setter
  - Preferred for direct communication.
* `$emit` with value.
  - Avoid. (see `$broadcast` above)

### Parent triggers Child

* ["Api publishing"][1] style of event binding with &
  - Not explored. May be clean, but also verbose.
* `$watch` in child scope on some inherited, bound (= <), or service-gotten object.
  - Avoid. Watches should be minimized because they slow down the page.
* `$broadcast`
  - Avoid. (see `$broadcast` above)

[1]: http://stackoverflow.com/questions/37439300/communicating-events-from-parent-to-child-in-angularjs-components#answer-37449259 "Api publishing in angular event binding"

### Child triggers Parent

* Event binding with &
  - Preferred. Modular and explicit.
* Parent `$watch` on some inherited, bound (= <), or service-gotten object.
  - Avoid. (see `$watch` above)
* `$emit`
  - Avoid. (see `$broadcast` above)
