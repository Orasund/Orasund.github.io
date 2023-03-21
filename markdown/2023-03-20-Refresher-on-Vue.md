https://vuejs.org/guide

# Getting Started

## Introduction

For a functional style, one should use the Composition API, however it is a bit trickier to get started.
Option API does not really use Types, where as the Composition API does.

> Go with Composition API + Single-File Components if you plan to build full applications with Vue.

# Essentials

## Creating an Application

> An application instance won't render anything until its .mount() method is called.

## Template Syntax

`{{in text}}`

`v-html:"injecting html"`

`v:bind:id="binding variables to a attribute"`

`:id="shortcut for bind`

> Functions called inside binding expressions will be called every time the component updates, so they should not have any side effects, such as changing data or triggering asynchronous operations.

> If your component has a someAttr property instead of someattr, your code won't work. Templates inside Single-File Components are not subject to this constraint.

## Reactivity Fundamentals

> The reactive() API has two limitations:
> 
> 1. It only works for object types (objects, arrays, and collection types such as Map and Set). It cannot hold primitive types such as string, number or boolean.
> 2. we can't easily "replace" a reactive object because the reactivity connection to the first reference is lost:

Use `ref` over `reactive`. `ref` will always update the view, where as `reactive` will only update if its updated directly.

> When refs are accessed as top-level properties in the template, they are automatically "unwrapped" so there is no need to use .value

> Note that the unwrapping only applies if the ref is a top-level property on the template render context. As an example, object is a top-level property, but object.foo is not.

> If a new ref is assigned to a property linked to an existing ref, it will replace the old ref

## Conditional Rendering

> Generally speaking, v-if has higher toggle costs while v-show has higher initial render costs. So prefer v-show if you need to toggle something very often, and prefer v-if if the condition is unlikely to change at runtime.

## List Rendering

`v-model` can be used on inputs of different types, <textarea>, and <select> elements.
