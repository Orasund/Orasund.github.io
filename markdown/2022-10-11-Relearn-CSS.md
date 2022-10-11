Lets [Learn CSS](https://web.dev/learn/css) in 2022.

# Attribute selector

[Source](https://web.dev/learn/css/selectors/#attribute-selector)

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

# Pseudo-elements

Heres some magic for you:

```
p::first-letter {
  color: goldenrod;
  font-weight: bold;
}
```

this will make the first letter golden. like WOW.

Need the first line?

```
p::first-line {
  color: goldenrod;
  font-weight: bold;
}
```

Easy.

Similarly, we have
* `::backdrop` (for the backend of some element),
* `::marker` (for the marker of a list),
* `::selection` for selected text,
* `::placeholder` for placeholder text in inputs and
* `::cues` for subtitles in videos.

# Pseudo-classses

Here some more pseudo classes: 

* `:invalid` - for invalid inputs
* `:target` - for element that you jump to using `href="#myref"`
* `:empty` - for empty nodes
* `:not` - for negativ selection
* `:is` - for either or selection
