---
layout: post
title: "Single points of failure in IPv4"
---

[In my previous blog post]({{ '2023/11/12/nat-good.html' | relative_url}}), I made the bold claim that like NAT and HTTP's Host Header, was sufficient for our current internet needs, perfect enough to work around the limited number of IPv4 addresses. However, a recent revelation about government surveillance through Apple's and Google's notification servers has led me to reconsider. These IPv4 workarounds, I've realized, introduce critical vulnerabilities: they create centralized points of failure, starkly contrasting the decentralized ethos of the Internet Protocol.

## What are Notification Servers

Notification servers, operated by Apple and Google, are what deliver push notifications to devices. When an app wants to send a notification, it has to first send it to a notification server. Your device checks then with these servers to get new notifications. Your device periodically checks these servers for new alerts, There is no other way for an app to send notifications to Android and iOS users. This mechanism allows Apple and Google to see all your notifications from every app you use.

Recently, Apple and Google were exposed to have been surreptitiously [sharing users' notification histories](https://www.reuters.com/technology/cybersecurity/governments-spying-apple-google-users-through-push-notifications-us-senator-2023-12-06/) with law enforcement. With the benefit of Hindsight, it is obviously bound to happen when everyone's valuable information is conveniently gathered in one easy-to-access place. Although it appears that forcing everyone to use centralised notification servers might be driven by some hidden agenda, there are good reasons why apps cannot simply send notifications directly to users.

## Why Notifications Servers are needed

The rationale behind these centralized servers lies in the requirements of push notification technology: timely delivery and high availability. In an ideal world, each device would operate its server, accepting incoming messages directly from various sources. This is essentially what notification servers do — they passively gather messages. However, NAT makes this impossible. A device has to send a request out in order to receive responses back. A device must initiate an outbound request to receive responses, leading to increased CPU and battery usage. CPU and battery usage also scales linearly with the number of sources. With tens or hundreds of different apps on your phone all wanting to send you notifications, periodically sending packages to all these different servers is impractical.

## The IPv6 Game-Changer

Enter IPv6, where receiving messages from various sources is straightforward. Devices can actively listen for incoming connections without the need for constant outbound communication to each source, drastically reducing CPU usage. Most importantly, CPU usage stays constant, independent of the number of sources for notification. This negates the need for centralised notification servers, essentially turning your phone into a notification server.

## Beyond Notification Servers: IPv6 and Decentralized Communication

The deeper issue with IPv4 lies in its structural limitation: for two devices to communicate over the internet, at least one must have a global address, not hidden behind NAT. Since most consumer devices use NAT, communication often relies on third-party servers like WhatsApp, Telegram, or Gmail. While end-to-end encryption offers security, the dependence on central servers brings its own set of problems, including potential outages and privacy concerns. It is also nearly impossible to distribute truly open and free messaging tools and social media. Open source initiatives like Matrix, a messaging platform, and Mastodon, a social media platform require users to run a server which is quite difficult to set up and expensive to scale.

In contrast, IPv6 facilitates a more decentralized, robust internet ecosystem. It paves the way for open-source messaging platforms, making them as straightforward to set up as downloading an app. There is no need for the complicated process of finding a computer that is up 24 x 7 with a globally reachable IP and configuring the network. This shift could herald a return to the early, decentralized days of email, where messages were sent directly to the recipient's computer, denoted by the part of the email address after @, free from third-party control and the associated risks: there is no downtime because one intern pushes a wrong config, no terms of service to agree to that puts you at the mercy of the companies and no massive data leaks that harm everyone.

In essence, although IPv4 works so far with the series of hacks that largely resolve the problem of address depletion, IPv6 brings a lot more benefit than merely a large address space — it redefines our relationship with the internet, enhancing privacy, reliability, and freedom in digital communication.
