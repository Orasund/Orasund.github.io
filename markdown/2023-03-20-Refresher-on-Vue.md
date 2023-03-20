https://vuejs.org/guide

# Getting Started

## Introduction

For a functional style, one should use the Composition API, however it is a bit trickier to get started.
Option API does not really use Types, where as the Composition API does.

> Go with Composition API + Single-File Components if you plan to build full applications with Vue.

# Essentials

## Creating an Application

> An application instance won't render anything until its .mount() method is called.

## Template

`{{in text}}`

`v-html:"injecting html"`

`v:bind:id="binding variables to a attribute"`

`:id="shortcut for bind`

> Functions called inside binding expressions will be called every time the component updates, so they should not have any side effects, such as changing data or triggering asynchronous operations.

