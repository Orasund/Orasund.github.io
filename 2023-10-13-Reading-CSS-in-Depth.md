# Reading CSS in Depth

## Part 1 - Reviewing the fundamentals

### 2. Working with relaitve units

* **Use a CSS Reset**

```
:root {
  font-size: calc(0.5em + 1vw);
}
```

### 3. Mastering the box model

globally set box-sizing to border-box

```
:root {
  box-sizing: border-box;
}

*,::before,::after {
  box-sizing: inherit;
}
```

Use display: table for columns of equal height

## Part 2 - Mastering layout

### 7 Positioning and stacking contexts

Child elements will be rendered together. So a stacking context on the parent effects all children.

To display the header on top without using z-index, you can ensure that its the last child in the <body> and then use position:absolute to place it on top.

### 8 Responsive Design

> The three key principles to responsive design:
> 1. A mobile first approach to design. This means you build the mobile version before you construct the desktop layout.
> 2. The @media at-rule. With this rule, you can tailor your styles for viewports of different sizes. This syntax (often called media queries) lets you write styles that only apply under certain conditions.
> 3. The use of fluid layouts. This approach allows containers to scale to different sizes based on the width of the viewport.
