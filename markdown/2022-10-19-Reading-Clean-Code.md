[Video: Hot Garbage: Clean Code Is Dead
](https://www.youtube.com/watch?v=s_fZFBgA11s)

Clean Code/DRY Code might be good to read an maintain, but bad to refactor. Using the Boy Scout Rule is a good way of making code slowly more "clean/DRY". But whenever you need to change something, you don't have to follow the "clean rules" - leave that to a later state in the development.

[Podcast: A Path to Better Programming • Robert "Uncle Bob" Martin & Allen Holub • GOTO 2021](https://www.youtube.com/watch?v=QnmRpHFoYLk)

Bob Martin is questioning why Design Patterns are semingly nolonger relevant. Also from the conversation it seems like these books are lessens learned from the last 15 years. The idea is, what new developers should not reinvent the wheel but continue from where old developers have left off.

# The Boy Scout Rule

> Leave the campground cleaner than you found it

# Meaningful Names

> Use speaking names. 

Explain the code should be the same as reading the code out loud.

-> This is exactly what I would call "self documenting code".

> The length of a name should correspond to the size of its scope

So finally we have solved the problem how to name linear(single use) variables:
The outer most variable has the full name (say "model") going inwards the naming can be "m1","m2" and so on.

# Functions

Functions should be grouped with in a file such that generic functions are on the top and more specific functions are at the bottom. To scrolling though the file should make things more specific.

-> This is actually the exact opposite of how i like to do things. I like my files to be read like a cookbook recipe: To get a more in-depth understanding of the function, you have to scroll upwards. The most general function will always be found a the end of the file

> Three arguments should be avoided where possible.

Personally i do support this, assuming i have unnamed records. Without that, i need to have a class for every function -> but a class needs a constructor -> so i need a class for my constructor? Using the factory pattern, just because we don't have unnamed records is also a stupid idea. Better we just allow function with more arguments, but then enforce, that we use named arguments.

## Don't Repeat Yourself

Don't duplicated code.

-> This is a double edged sword. Creating an abstraction for the wrong thing is often more harmful than actually duplicating the code. So a good practice might be to allow duplication while you are writing the code and then once you are finished you can see if you feel like something repeats. (not Everything that looks the same, is actually the same. Sometime its just a coincidence.)

# Comments

> Explain Yourself in code

> Don't Use a Comment When You Can Use a Function or a Variable

# Data Abstraction

-> sounds very outdated. Tried to make a point for private properties

# Data Transfer Objects

-> also feels outdated. Seems like data classes just did not exist yet. Saying that logic might live in the Data Transfer Object just feels wrong.

# Error Handling

-> Making an argument against Checked Exceptions, saying it violated the Open/Closed Principle because you would have to pass the exception declarations through each layer. **But thats one of the core principles or functional programming.** Make everything super transparent. Forcing you to add these declaration should make you think if you might catch them earlier and if not - what do these declaration actually mean in your context? Is this just noise or real exception that can happen in real life? Should we maybe find an alternative solution to throwing an exception?

> Don't Return Null

-> Again, this feels outdated. Something you actually want to say "i can't do this" or "i was successful, but the result is empty". In these cases Null makes perfect sense. Its also very easy to handle (nowadays).
