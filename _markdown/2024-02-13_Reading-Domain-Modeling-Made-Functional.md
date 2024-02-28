# Domain Modeling Made Functional

# Understanding the Domain

## Introducing Domain-Driven Design

Behavoir-Driven Design can be though of as "Events-First" Design or "Data Types follow Events".

Event Storming is a type of workshop where the participates define Events in there Buisness. See The same book by Alberto Brandolini for more infos.

> Sounds good. So now what do we do? Where should we start?
> The first guideline says “focus on business events,” so let’s use an eventstorming session for that. Here’s how one might start out at Widgets Inc.
>
> You: “Someone start by posting a business event!”
> Ollie: “I’m Ollie from the order-taking department. Mostly we deal with orders and quotes coming in.”
> You: “What triggers this kind of work?”
> Ollie: “When we get forms sent to us by the customer in the mail.”
> You: “So the events would be something like ‘Order form received’ and ‘Quote form received’?”
> Ollie: “Yes. Let me put those up on the wall then.”
> Sam: “I’m Sam from the shipping department. We fulfill those orders when they’re signed off.”
> You: “And how do you know when to do that?”
> Sam: “When we get an order from the order-taking department.”
> You: “What would you call that as an event?”
> Sam: “How about ‘Order Available’?”
> Ollie: “We call an order that’s completed and ready to ship a ‘Placed Order.’ Can we agree on using that term everywhere?”
> Sam: “So ‘Order Placed’ would be the event we care about, yes?”
> 
> You get the idea. After a while, we might have list of posted events like this:
> * ‘Order form received’
> * ‘Order placed’
> * ‘Order shipped’
> * ‘Order change requested’
> * ‘Order cancellation requested’
> * ‘Return requested’
> * ‘Quote form received’
> * ‘Quote provided’
> * ‘New customer request received’
> * ‘New customer registered’

## Understanding the Domain

## A Functional Architecture

//TODO
