# HTML Styling (SCSS) Best Practices

This document is inteneded to give 

## Box-sizing

At this point, `box-sizing: border-box` is almost universally used in CSS. This
ensures that your elements' dimensions INCLUDE padding AND border. We tend to
like this especially in cases where elements have % widths. With normal
settings, adding padding or border thickness would destroy these layouts!

## Padding and Margins

In general, the best way to think of padding and margins is as follows:

Padding is space you want to create INSIDE an element and,
Margin is space you want to create AROUND an element

### Percentage Values

Padding and margin will always reference the width of the parent element when
you use a percent value. This provides a great trick for maintaining aspect
ratio on an element (particularly useful for images).

### Gotchas

#### Margin-top

If you have an element without top-padding specified and the first element has
margin-top set, that margin will appear as if it were on the enclosing element.
To prevent this, you should either (1) specific a top padding (even 0 will do)
or (2) 

## 

## Alignment

Align is pretty straightforward with modern browsers, but in order to support
older versions we have to use some tricks

### Center alignment

### 

### Width %s and inline-block

If you are trying to fill a page with, say, four 25% width elements, it's best
to avoid using `display: inline-block`. This is because any space between the
elements in your HTML will display on the page and cause the last element to
go off the page.

It's much better to use `float: left` on the elements or `display: flex` on the
enclosing element.

This is the reason why Bootstrap and other CSS scaffolds use floats in their
older versions (most have moved or are moving to use `flex`).

## Odds and Ends

### Backface Visibility

Backface visibility is a setting that allows you to see the "back" of an
element during 3D animations.

To be safe, it might help to use the rule `backface-vibility: none;`

### Z-Indexing

## Animations

### Transitions

The simpliest, and often cleanest, way to implement animations is by adjusting
a property on a state (`&:hover`) or by changing that property if a class is
added

One nice effect is to include a different `transition-duration` on the new
state from the original. This can be nice for slower transitions when your
cursor leaves a button (for example).

### @animations

For 

## Linting

See ________.