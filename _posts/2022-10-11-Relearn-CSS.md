---
title: "Relearn CSS"
tags: [Video]
---
# Relearn CSS

Lets [Learn CSS](https://web.dev/learn/css) in 2022.

## Attribute selector

[Source](https://web.dev/learn/css/selectors/#attribute-selector)

### [..]

Did you know you could write

```
[data-type='primary'] {
  color: red;
}
```

for

```
<div data-type="primary"></div>
```

to make the color turn red?

You can also do

```
[data-type] {
  color: red;
}
```

if you are not interested in the value.

You can also do some pattern machting

```
/* A href that contains "example.com" */
[href*='example.com'] {
  color: red;
}

/* A href that starts with https */
[href^='https'] {
  color: green;
}

/* A href that ends with .com */
[href$='.com'] {
  color: blue;
}
```

if you really wanna feel special.

## Pseudo-elements

### ::first-letter

Heres some magic for you:

```
p::first-letter {
  color: goldenrod;
  font-weight: bold;
}
```

this will make the first letter golden. like WOW.

### ::first-line

Need the first line?

```
p::first-line {
  color: goldenrod;
  font-weight: bold;
}
```

Easy.

### Other tricks

Similarly, we have
* `::backdrop` (for the backend of some element),
* `::marker` (for the marker of a list),
* `::selection` for selected text,
* `::placeholder` for placeholder text in inputs and
* `::cues` for subtitles in videos.

## Pseudo-classses

### Some more tricks

Here some more pseudo classes: 

* `:invalid` - for invalid inputs
* `:target` - for element that you jump to using `href="#myref"`
* `:empty` - for empty nodes
* `:not` - for negativ selection
* `:is` - for either or selection

## Functions

### var()

Writing Variables is easy.

```
:root {
	--base-color: #ff00ff;
}

.my-element {
	background: var(--base-color);
}
```

### attr()

you can even get the value of an attribute.

```
a::after {
  content: attr(href);
}
```

### url()

You can also fetch data from an url

```
.my-element {
	background-image: url('/path/to/image.jpg');
}
```

### calc()

You can actually also do proper maths

```
.my-element {
	width: calc(100% - 2rem);
}
```

### min() and max()

Taking minima and maxima of two values is also possible

```
.my-element {
  width: min(20vw, 30rem);
  height: max(20vh, 20rem);
}
```

### polygon()

You can even clip items

```
.polygon {
  clip-path: polygon(0% 0%, 100% 0%, 100% 75%, 75% 75%, 75% 100%, 50% 75%, 0% 75%);
}
```

### scaleX() and scaleY()

```
.my-element {
  transform: scaleX(1.2) scaleY(1.2);
}
```
