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
