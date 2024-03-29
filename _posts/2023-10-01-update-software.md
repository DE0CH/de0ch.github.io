---
layout: post
title: "To update or not to update, that is the question"
---

Picking up a coding project that I haven't touched for a year or two, I have come to expect that nothing about it still works and I need to update all of its components and my code to get it to work again. I didn’t realize how strange this was until I compared it to other things. If I leave a book unattended for many years, it won’t just fall apart for no reason and if I pick up my camera after a few years, it will still take pictures.

So why is this not the same with software, why do we have to deal with constant updates that risk introducing new bugs into existing systems that work perfectly fine?

## Security Update

The main culprit: security update. Because everything is connected to the internet all the time, your devices face constant threats. Your phone can get hacked just by reading a message because of stack overflow, sandbox escape, etc. There are bugs — logical errors — made by programmers that grant control to unauthorized parties. Compare this to things that are not connected to the internet: unless someone has physical access to something, they cannot control it. Because the laws of physics are written by God, there aren't any bugs or exploits so things that don’t connect to the internet never need to be updated to fix security vulnerabilities.

You might ask, I was fine with using the software before a fix was applied for so long, so why would I not be fine after the security fix is released? The answer: no one knew about the bug beforehand (or at least, few people knew), but after the fix is published, especially for open-source software, everyone knows about and can develop exploits for those unpatched systems so your risk of getting hacked increases after a security update is published.

## New Incompatible Features

Security updates explain why we need updates even if we don’t want them. Updates break existing features for a different reason. It’s because of the tradeoff between maintaining backward compatibility with old technology and the new features and quality of life improvement brought by new technology.

In real life, we make this tradeoff all the time. We updated our method of communicating with someone from writing letters to writing text messages over the internet because the benefits are huge even though that means we need to learn new ways of communicating and adapt our lifestyle around it, but we didn’t update our keyboard layout to something more efficient because it’s difficult to learn a new keyboard layout for a small amount of gain in efficiency.

The same tradeoff applies to the software world. While it is technically easy to maintain all the backward compatibility of a piece of software, this sometimes comes into conflict with new features. Usually, an update to break backward compatibility is made to fix problems with confusing design and introduce new features that are not allowed by the old design.

Windows has a good reputation for maintaining backward compatibility. One example is the control panel. When Windows rewrote the settings page in Windows 8, it preserved the control panel introduced in Windows 7, and it is kept in Windows to this day, 14 years after Windows 7 was released. This confuses new users because there are two very different programs that do the same thing. It looks ugly because they use different themes. The advantage is clear though. I can still follow tutorials written years ago, even those written for Windows 7, and what I remember from my childhood still works.

For other software, the thought process is the same, the specs of a programming language gets updated to fix confusing design that cause pitfalls to new and unfamiliar users or make it easier to maintain and develop programs. Depending on the popularity of the new version, developers decide if they should drop support for the older version. It took the developers of Python 10 years to drop support for the older version 2 of Python after the new version 3 came out. For Perl, version 5 was so popular that its successor version 6 was eventually renamed because of the incompatibility and people’s desire to keep using the old one despite its numerous pitfalls and stupid design choices.

Maintaining backward compatibility is like not changing your room layout because if you change it, the robot cleaner gets confused the stops working even though the layout was proven to be not logical. Whether to change the layout depends on how important the robot is and how difficult it is to update it to make it work with the new layout as well as how much more logical the new layout is.

When software gets updated, it becomes harder and harder to develop fixes for the older versions because the code bases diverge over time. When developers decide to drop support for an old version — usually meaning stopping applying new security fixes to it, users are usually forced to upgrade to the new version lest they leave their machines vulnerable to hacks. This is why programs constantly need updates and updates sometimes break things that already work.
