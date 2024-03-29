---
layout: post
title: "How big is the universe? It's so big that it's bigger than itself. (Russell's Paradox)"
---

We investigate infinity with set theory, which deals with sets - collections of things, like the set of all natural numbers and the set of all polygons. Sets can contain anything (including sets) and can be however large. But even though a set can be easily larger than the entire physical (not just the observable) universe, there are sets that are too large to be a set. One of them is the set of everything (a.k.a. the universal set). Known as the Russell's Paradox, the proof itself is as spectacular as the result: the attempt to create a foundation for math through set theory accidentally created a creature too large to be contained. 

# A Short Proof

The original version of the proof is effective and succinct. It goes as follows.

Let's assume that the universal set exists. Now we construct a set $S$ such that it contains all sets that do not contain itself. Symbolically,

$$ S = \{ x \in U: x \notin x \} \text{,}$$

where $U$ is the universal set.

Now, does $S$ contain itself? If it does, by definition, it does not, and vise versa. Let that sink in.

Although the argument is logically correct and sound, it's a bit hard to understand and, in my opinion, does not capture the essence of the paradox -- the universal set is too "big" to be a set, and self reference is not the culprit [^ban-self-reference]. Therefore, I would like to introduce an alternative (and equivalent) view of the proof, which is similar to Cantor's diagonal argument. It's a bit more involved and longer, but it gives you a much better grasp of what the universal set looks like and why exactly it doesn't exist.

# Terminology Disambiguation

Every entity/thing in our discussion is a set. This is because all mathematical structures -- numbers, functions, shapes, spaces, etc. -- can all be represented as sets. Only having sets in our discussion simplifies our structures [^set-definition]. An "element" is also a set, but it puts emphasis on the fact that it is contained in another set. So you may find me referring to the same thing as both a "set" and an "element". That is because a set is an element of another set.

# A Small Universe

Tackling the universal set directly can be quite daunting and disorientating because it's infinite in size. So we will start with a smaller "universal" set. We will prove that the universal set contains more than 5 elements. (If you are familiar with Cantor's diagonal argument, you may skip to the section "A Large Universe".)

No duh, you say. That so obvious that we don't need a proof. But stick with me, if we meticulously examine the underlying logic for our intuition, we can apply the similar logic to a bigger case where intuition fails.

Let's say the only elements in our universe are 🍟, 🍕, 🥪, 🌮, 🥨. Since these are the only elements in the "universe", it follows that any set contains a combination of the elements in the "universe". For example,

- 🍟 = {🍕} 
- 🍕 = {}
- 🥪 = {🥪, 🌮} 
- 🌮 = {🍟, 🍕, 🥪, 🥨} 
- 🥨 = {🍟, 🍕} 

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

The rows of the table denote what the sets contain. ✅ means that the set in the row contains the element in the column, and 🅾️ means that it does not. 

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

You might notice that there are a lot of combinations of the five sets that are not in the universe. For example, the set {🍕, 🌮} is not in the "universal" set. Right now, we can just think of such a set by looking at it, but as the universe gets larger, we need a systematic way finding a set that is not in the universe. 

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

And then we flip whether it is an element of its set. 

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

This is not an element of the "universal" set because it's different from every element by one element. For example, it's different from 🍟 because 🍟 does not contain 🍟,but the new element contains 🍟 (as we flipped the diagonal).

Note that we don't actually need to use the strict diagonal; we can use other combination as long as we cover all the bases. For example, we can choose the following elements. 

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
        <td>🅾️</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <th>🍕</th>
        <td>✅</td>
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
        <td>✅</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>🅾️</td>
        <td>✅</td>
    </tr>
</table>

Now that we have made at least one element that is not in the set, we can conclude that the universal set, which should contain every possible set, has more than $5$ elements. A set of $5$ elements is too small to contain the universe! By the look of it, we need at least $2^5 = 32$ sets to cover all the combinations of the $5$ sets, but that only shifts the problem back. By the time our set is $32$ element large, we need $2^{32} = 4294967296$ sets to cover all the combination of the $32$ sets, and ad infinitum. Just like exponential growth, the size quickly explodes.

Our problem at hand is, unfortunately, worse than ad infinitum. The universe can't even be contained by a set of infinite set! Let's apply our reasoning to the actual universal set to see why.

# A Large Universe

Let's assume that the universal set exists. Just like before, we write out the universal set in the following table. Naturally the sets we had before are also elements of the universal set, so we will write them out first. 

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
        <td></td>
    </tr>
</table> 

Similarly, we can also construct an element by inverting the diagonal elements, to make something like 

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
        <td>✅</td>
        <td>...</td>
    </tr>
</table>

But this element is not in the universal set, because it is different from every set by one element. Therefore, we reach a paradox such that no matter how big the universal set is, it can be bigger. 

So what? Can't we just make it bigger and include the new element? Yes, but the key is that we have already *assumed* that we have everything in the universal set at first. We have reached a contradiction. We have carefully reasoned our way through, so the problem must lie the assumption. It is also important to note that this is different from infinity. Infinity, in set theory, is a defined concept, whereas this is a logical paradox.

Notice that flipping the diagonal elements is essentially the same as saying "include every element that does not include itself", because if the diagonal element is 🅾️, it means it does not contain itself. We the flip it so that the new set contains it, and vise versa. With this view in mind, if we ban self reference, our argument would still work, because we don't really have to choose the diagonal elements. We can, for example, shift the selection to the left or right by one.

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
        <td></td>
    </tr>
</table> 

We flip the elements and make a new set that is not an element of the universal set. For the first element of the set, it doesn't matter if we include it or not. Just like before, this new element is different from all the elements in the universe.

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
        <td>...</td>
    </tr>
</table>

Also, just like last time, we can choose any random elements, as long as we make sure to choose at least one unique element from every set. 

For those who desire some more mathematical formalism, the above sentence translates to the following statement.

$$S = \{x \in U: x \notin f(x) \}$$

where $f$ is a surjective function from $U$ onto $U$. Now we ask: is $f^{-1}(S)$ [^inverse-function] in $S$? It if isn't in $S$, it is in $S$, and if it is in $S$, it is not in $S$. 

In this argument, we didn't really make use of self reference because that is not the root cause of the paradox. It is rather because the universe is too big to be a set. 

# Conclusion

Hopefully, by now you have gotten an intuitive sense why the universal set is too big to be a set. No matter how big the universal set it, it should be much much bigger. It also follows that for any set, no matter how large, is the small part compared to all the set that exists. This really humbles us. There is so much out there that is unknown, beyond what our eyes can see and the physical universe. Whether you believe these sets are objective existence in Plato's world of forms, it's truly breathtaking to see the curious properties of the universe of sets. 

This paradox does not break set theory, but it rather shows that unrestricted comprehension -- one can add whatever to a set -- leads to inconsistency, a set that is too big to be a set. So mathematicians have to very careful making a set bigger, through more "restricted" comprehension such as the Axiom of Pairing, the Axiom of Union, and the Axiom of Power Set. If you want to study it further, please look up Zermelo–Fraenke (ZFC) set theory. 

If we want to be fancy, we can proclaim "God is dead, and the universe doesn't exist!"

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" />

[^continuum-hypothesis]: I am referring to the continuum hypothesis here. 

[^set-definition]: Another major motivation of set theory is to formalize all systems of math in order to make them rigours, creating a solid foundation for used-to-be "intuitive" axioms and definitions. This scheme would best avoid inconsistency and falsehood.

[^ban-self-reference]: It's tempting to argue that we can avoid the paradox all together if we disallow a set to contain itself, but that is not a valid because a similar paradox can be formed. It will be much clearer as we introduce the new view. 

[^inverse-function]: Because $f$ is a surjection function, it does not have an inverse in the algebraic sense, but for now, we can view $f^{-1}(x)$ as *one of* the input that would give $x$ when inputted to $f$. 
