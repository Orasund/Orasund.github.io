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

#### 3.2.3 Using min-height and max-height

TODO
