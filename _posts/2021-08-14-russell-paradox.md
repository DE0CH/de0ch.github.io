---
layout: post
title: "How big is the universe? It's so big that it's bigger than itself."
custom_css: cantor-table
---

Set in set theory deals with sets -- collection of things -- like the set all natural number is a set and the set of all polygons. Sets can contain anything (including sets) and can be however large. But even though a set can be easily larger than the entire physical (not just the observable) universe, there are sets that are too large to be a set. One of them is the set of everything (known as the universal set). Known as the Russell's Paradox, the proof itself is as spectacular as the result. The attempt to create a foundation accidentally created a creature too large to be contained. 

# A Short Proof

The original version of the proof is effective and succinct. It goes as follows.

Let's assume that the universal set exists. Now we construct a subset $S$ of the universal set (which is a new set that contains some of the elements in the original set) such that it contains all elements that does not contain itself. Symbolically,

$$ S = \{ x \in U: x \notin x \} \text{,}$$

where $U$ is the universal set.

Now, does $S$ contain itself? If it does, by definition, it does not, and vise versa. Let that sink in.

Although the argument is logically correct and sound, it's a bit hard to understand and, in my opinion, does not capture the essence of the paradox -- the universal set is too "big" to be a set, and self reference is not the culprit [^ban-self-reference]. Therefore, I would like to introduce an alternative (and equivalent) view of the proof, which is similar to cantor's diagonal argument. It's a bit more involved and long, but it gives you a much better grasp of what the universal looks like.

# Terminology Disambiguation

As I was revising the draft, I noticed that the word "element" can be a bit confusing. A set contains elements. An element is always relative to a set. So when I say "an element" it means an element of the set in context. 

Every entity/thing in our discussion is a set. This is because all mathematical structures -- numbers, functions, shapes, spaces, etc. -- can all be represented as sets. Only having sets in our discussion simplifies things [^set-definition]. So you may find me referring to the same thing as both a "set" and an "element". A set can be an element of another set.


# A Small Universe

Looking at the universal set directly can be quite daunting and disorientating because it's infinite in size. So we will start with a smaller "universal" set. We will prove that the universal set contains more than 5 elements. (If you are familiar with Cantor's diagonal argument, you may skip to A Large Universe)

No duh, you say. But stick with me, if we meticulously examine the underlying logic for our intuition, we can apply the similar logic to a bigger case where intuition fails.

The only elements in our universe are 🍟, 🍕, 🥪, 🌮, 🥨. Since these are the only elements in the universe, it follows that they are composed only of themselves, such as

$$\begin{aligned} 🍟 &= \{🍕\} \\ 🍕 &= \{\} \\ 🥪 &= \{🥪, 🌮\} \\ 🌮 &= \{🍟, 🍕, 🥪, 🥨\} \\ 🥨 &= \{🍟, 🍕\} \\  \end{aligned} $$

Alternatively, we can write it in a table form in the following way, which is useful for finding a set that is not the universe. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td>🅾️</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
    </tr>
    <tr>
        <th>🍕</th>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
    </tr>
    <tr>
        <th>🥪</th>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
    </tr>
    <tr>
        <th>🌮</th>
        <td>✅</td>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>✅</td>
    </tr>
    <tr>
        <th>🥨</th>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
    </tr>
</table> 

The rows of the table denote what the sets contain. ✅ means that the set in the row contains the element in the color, and 🅾️ means that it does not. 

For example, let's take a look at the third row

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>...</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
    </tr>
    <tr>
        <th>...</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table>

It means that the set 🥪 
- does not contain 🍟
- does not contain 🍕
- contains 🥪
- contains 🌮
- does not contain 🥨

You might notice that there are a lot of combinations of the five sets that is not in the universe. For example, the set $\{🍕, 🌮\} is not in the "universal" set. Right now, we can just think about a set by looking at the "universe", but as it gets larger, we need a systematic way finding a set that does not exists. 

For finding a new set that is not in the universe, we use a technique called diagonalization. 

First, we choose the elements on the diagonal row.

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🍕</th>
        <td></td>
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td></td>
        <td></td>
        <td></td>
        <td>🅾️</td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>🅾️</td>
    </tr>
</table> 

And then we flip whether it is an element of the set. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td>✅</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🍕</th>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td></td>
        <td></td>
        <td>🅾️</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td></td>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✅</td>
    </tr>
</table> 
 
Based on the diagonal states, we make a new element.

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>?</th>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>✅</td>
    </tr>
</table>

This is not an element of the "universal" set because it's different from every element by one element. 

Note that we don't actually need to use the strict diagonal, we can use other combination as long as we cover all the bases [^all-bases]. For example, we can choose the following elements. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🍕</th>
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td></td>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>🅾️</td>
    </tr>
</table> 

Like before, we flip them. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🍕</th>
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td></td>
        <td></td>
        <td></td>
        <td>🅾️</td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td></td>
        <td></td>
        <td>🅾️</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>️✅</td>
    </tr>
</table> 

And make a new set that is not in the universe.

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
    </tr>
    <tr>
        <th>??</th>
        <td>🅾️</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>✅</td>
    </tr>
</table>

Now we have made at least one element that is not in the set. We can conclude that the universal set, which by definition contains every set, has more than 5 elements. A set of 5 elements is too small to contain the universe! By the look of it, we need at least $2^5 = 32$ sets to cover all the combinations of the 5 sets, but that shifts the problem back. By the time our set is 32 element large, we need $2^{32} = 4294967296$ sets to cover all the combination of the 32 sets, and ad infinitum. Just like exponential growth, the size quickly explodes.

Our problem at hand is, unfortunately, worse than ad infinitum. The universe can't even be contained by a set of infinite set! Let's apply our reasoning to the actual universal set.

# A Large Universe

Let's, for now, assume that the universal set exists. Just like before, we write out the universal set in the following table. Naturally the sets we had before are also elements of the universal set, so we will write them out first. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
        <th>...</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td>🅾️</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>...</td>
    </tr>
    <tr>
        <th>🍕</th>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td>✅</td>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>✅</td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td></td>
    </tr>
    <tr>
        <th>...</th>
        <td>...</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table> 

Similarity, we can also construct an element by inverting the diagonal elements, to make something like 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
        <th>...</th>
    </tr>
    <tr>
        <th>?</th>
        <td>✅</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>✅</td>>
        <td>...</td>
    </tr>
</table>

But this element is not in the universal set, because it is different from every element in at least one place. Therefore, we reach a paradox such that no matter how big the universal set is, it can be bigger.

So what? Can't we just make it bigger and include the new element? Yes, but the key is that we have already *assumed* that we have everything in the universal set at first. We have reached a contradiction. We have carefully reasoned our way through, so the problem must lie the assumption. It is also important to note that this is different from infinity. Infinity, in set theory, is a defined concept, whereas this is a logical paradox.

With this view in mind, if we ban self reference, our argument would still work, because we don't really have to chose the diagonal elements. We can shift the selection to the left or right by one.

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
        <th>...</th>
    </tr>
    <tr>
        <th>🍟</th>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
        <td></td>
        <td>...</td>
    </tr>
    <tr>
        <th>🍕</th>
        <td></td>
        <td></td>
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🥪</th>
        <td></td>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🌮</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✅</td>
        <td></td>
    </tr>
    <tr>
        <th>🥨</th>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>...</th>
        <td>...</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table> 

We flip the elements and make a new set that is not an element of the universal set. For the first element of the set, we can either choose to include it or not. Just like before, we are different from all the table. We have found another element that is nowhere to be found in the able. 

<table class="table-2d">
    <tr>
        <th></th>
        <th>🍟</th>
        <th>🍕</th>
        <th>🥪</th>
        <th>🌮</th>
        <th>🥨</th>
        <th>...</th>
    </tr>
    <tr>
        <th>???</th>
        <td>✅</td>
        <td>🅾️</td>
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
    </tr>
</table>

Formally, we can make the following statement.

$$S = \{x \in U: y \notin f(y) \}$$

where $f$ is a surjective function from $U$ onto $U$. Now we ask: is $f^{-1}(S)$ [^inverse-function] in $S$? It if isn't in $S$, it is in $S$, and if it is in $S$, it is not in $S$. In this argument, we didn't really make use of self reference because that is no the root cause of the paradox. It is rather because the universe is too big to be a set. 

# Conclusion

Hopefully, by now you have gotten an intuitive sense why the universal set is too big to be a set. No matter how big the universal set it, it should be much much bigger. It also follows that for any set, not matter how large it is, is the small part compared to all the set that exists. This really makes us humble. There are so much that is out there that is unknown, beyond what our eyes can see and the physical universe. Whether you believe these sets are objective existence in Plato's world of form, it's truly breathtaking to see the curious properties of the universe of sets. 

If we want to be fancy, we can proclaim "God is dead, and the universe doesn't exist!"

[^continuum-hypothesis]: I am referring to the continuum hypothesis here. 

[^set-definition]: Another major motivation of set theory is to formalize all systems of math in order to make them rigours, creating a solid foundation for used-to-be "intuitive" axioms and definitions. This scheme would best avoid inconsistency and falsehood.

[^ban-self-reference]: It's tempting to argue that we can avoid the paradox all together if we disallow a set to contain itself, but that is not a valid because a similar paradox can be formed. It will be much clearer as we introduce the new view. 

[^inverse-function]: Because $f$ is a surjection function, it does not have an inverse in the algebraic sense, but for now, we can view $f^{-1}(x)$ as *one of* the input that would give $x$ for $f$. 
