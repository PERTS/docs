# Jest and Enzyme Testing Best Practices

## Use Wrapper API

Be familiar with the [Enzyme docs][1] and what API you can use to interact with a shallow- or fully-rendered wrapper.

Some convenient ones are:

- `first()`
- `forEach()`

## Retrieve components from the wrapper fresh every time

Otherwise they will be unpredictably stale. Can write quick getters:

```
const myInput = wrapper => wrapper.find('input[name="foo"]');
myInput(wrapper).props(); // always fresh!
```

## Tricks for finding nodes

The wrapper is not the DOM. Instead, it's a component tree, and all we have is components and their props. That means if you're searching based on "attributes", you have to use the React versions, like:

```
wrapper.find('label[htmlFor="foo"]');
```

## Tricks for simluating events

[Per the docs][2] `simulate` doesn't actually trigger events, because the wrapper is not the DOM. Instead, it's a component tree, and all we have is components and their props. That means it uses event-handling prop functions like `onClick` or `onChange`.

On top of that, it's tricky to simulate the event you want. Recipes follow.

### Select a checkbox or radio input

```
myRadioInput(wrapper).simulate('change', {currentTarget: {checked: shouldBeChecked}});
```

### Type in a text field

```
myTextInput(wrapper).simulate('change', {currentTarget: {value: "My hands are typing words."}});
```

### Submitting a form

**Not fully tested**

Try either/both of these:

- `mySubmitButton(wrapper).simulate('click')`
- `myForm(wrapper).simulate('submit')`

[1]: https://airbnb.io/enzyme/ 'Enzyme Docs'
[2]: https://airbnb.io/enzyme/docs/api/ReactWrapper/simulate.html '`simulate()` docs'
