---
layout: post
title: "Why Decentralised Web Fails"
---

Recently, or rather a few years ago, there has been quite some buzz with web 3.0 powered by blockchain. To me, this is complete nonsense. Technology before blockchain is more than enough to enable a decentralized web. Decentralization did not happen rather because it is inefficient and therefore outcompeted by centralization. 

Blockchain, on the other hand, solves a completely different problem that has little to do with decentralization. So allow me to first go on this tangent to explain why blockchain is irrelevant.

## Trusted Timestamp: the Only Problem That Blockchain Solves

When we think of blockchain technology, we often associate it with a transparent ledger, an immutable database, and a collaborative environment. But this is not thanks to blockchain, it is rather thanks to other technologies like peer-to-peer networks and cryptography. You can verify if a message is sent from someone by verifying the digital signature and you can send messages across the internet without a central server by using peer-to-peer network protocols, barring some technical limitations like the limited address space of IPv4. The only feature of blockchain is the trusted generation of a timestamp of an event.

Knowing the time something happens is often critical. For example, if someone spends more money than they have, we should invalidate any payment that happens after they deplete their account. This is traditionally done with a trusted third party, like a bank. Without blockchain and a trusted third party, this is impossible to achieve. After all, anyone can lie about when something happens. There's no way for any reader of the message to verify if the claimed timestamp is accurate because they could be offline for a while and therefore receive updates out of sync with the actual time they are being sent. Blockchain solves this problem by having everyone vote using their computational power whether they think that an event indeed happens at the time the timestamp claims, or more technically, they vote for the event that claims to happen after the most credible course of history.

Knowing the actual time something happens is important for many applications like trading but for many other things, it is not really important. For example, it's less important to know when I have published this blog post than that I published this at all and you can read it in its original form untempered thanks to cryptography. It is also not important to know when a file like a TikTok video is created for you to enjoy it.

## Technology Today Is Sufficient for Decentralised Web

Today, you can start hosting a website for close to $0 per month. I host this blog on GitHub pages which costs me nothing and I am able to control the appearance and content of the website. For more complicated apps that, for example, need a database, some platforms do that for free or for a small fee (Heroku used to be a good and free option, although they no longer offer the free plan). If nothing fits your needs, you can always just rent a low-cost computer on Amazon Web Services for a few dollars a month that can do anything. You can also reuse your current computer and internet connection at home to host any website for free. The only technical limitation currently is that one must host a server from a computer that has a public IP, which excludes most mobile and some residential internet connections, but the problem is easily also solved by a reverse proxy/tunnel like playit.gg or ngrok which costs a few dollars a month.

For anyone unfamiliar with coding, there are plenty of open-source tools that streamline the process. The decentralised social media platform Mastodon has guides for setting up your own server to serve content.

Ultimately, it is not that expensive or difficult to start hosting your own website, your own social media platform, or your own anything. The only limit is your skills and imagination.

## Decentralization Is Inefficient

So why isn't the web sprawling with self-hosted services and websites? This might be because they get outcompeted by bigger and more centralized businesses. Bigger businesses are inherently more efficient and are even more so for tech-related companies. Software has near zero marginal cost and high fixed costs. Therefore a bigger company that has more resources to develop better features can easily out-compete smaller ones. Also, because the marginal cost is zero and most fixed costs like engineering time already spent are sunk costs that should not be considered, competition drives down the unit price to near zero. As a result, the better product developed by big companies easily outcompetes the decentralised ones developed by dedicated communities by either having a better product or better marketing strategy. This is, I believe, more beneficial for consumers as we get better products by paying the same price regardless -- near zero. This is also a better allocation of resources because instead of spreading a society's engineering time to numerous competing products, it is spent on making a few products much better.

Surely, you may say, cooperations should let users host the server programs on their own devices rather than on centralised servers since it costs them nothing either way. But why should they? Centralised servers are far more reliable, and create a better user experience as users don't need to download a lot of data and code used by servers and it is cheaper to develop and optimise because the target hardware platform is known with few variations. It also makes the software less likely to get stolen. So we will probably never see popular centralized services implemented in a decentralised way.

## Decentralised Web Ends up Being Used for Illegal Stuff

Decentralised web gets easily outcompeted for anything legal so it sometimes unfortunately ends up being used for illegal purposes.

Take the BitTorrent protocol as an example. The protocol allows users to do peer-to-peer file transfer without a central storage server. This has the benefit that anyone can put files into the system without paying for any storage and internet costs, and that files in the system can not be censored by authority. It can also download files much faster than centrally hosted files because one can get the file from the closest computer that also runs BitTorrent, which can be much closer, especially for smaller businesses that cannot afford to host many data centres around the world. This technology was invented in 2001. Today, it is often used for pirating software and movies without mainstream adoption. The biggest reason, I believe, is that there is no mainstream support for this protocol. It is not built into any browser like http or ftp: you cannot just click on a link and start downloading straight away. You have to install a dedicated BitTorrent client. Apple explicitly bans any app capable of downloading torrent files.

This is pure speculation, but I believe the reason BitTorrent is not built into most browsers is because it can really hurt their business. After all, who will spend $10 for a movie on YouTube when they can just click on a link on The Pirate Bay and start watching the same thing in the same definition with no ad? I think similar things will also happen to any other decentralised technologies that stop them from getting mainstream adoption. 

Cryptocurrencies, especially privacy-focused ones like Monero are mostly used by criminals because of their intractability. According to CNBC, in the first half of 2018, Monero was used in 44% of cryptocurrency ransomware attacks[^monero-source]. 

## Optimism or Stockholm Syndrome?

Although a decentralised web sounds like a utopia: no evil corporation controls the flow of information or spread propaganda, a centralised web is not necessarily a bad thing. In fact, it is good because a centralised web and by extension, centralised expertise, can create better products that are easy to use and boost innovation than a decentralised web. But at the end of the day, I've not seen a decentralised web fully implemented so I have no direct comparison, so this might be just Stockholm Syndrome.

[^monero-source]: Source: <https://www.cnbc.com/2018/06/07/1-point-1b-in-cryptocurrency-was-stolen-this-year-and-it-was-easy-to-do.html>