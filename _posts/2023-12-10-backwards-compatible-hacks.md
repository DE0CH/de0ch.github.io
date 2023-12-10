---
layout: post
title: "The backward compatible hack that keeps the web together"
---

The internet is nothing short of a modern miracle. It's astonishing that I can video call friends and family in China from halfway across the globe in the UK with almost seamless connectivity. My luggage get lost in transit and things I tried to send through mail gets stopped by custom, yet tiny changes in electrical current somehow manage to get through dozens of networking devices run by different groups of people with various technical ability and agenda somehow make it to the other end with remarkable reliability. 

This robust and advanced state of the internet we enjoy today owes much to standardization, good algorithm designs and, just as importantly, a series of clever backwards-compatible hacks. These innovations have introduced new features while maintaining connectivity through older hardware and software that have yet to be updated.

In this blog, I aim to explore some of these ingenious hacks that keep the internet functioning smoothly and the lessons they offer. By delving into these technological marvels, we can appreciate the intricacies and brilliance behind our daily digital interactions.

## Backwards compatible hacks

### Network Address Translation

In my previous blog post, I touched on the significance of Network Address Translation (NAT) and its operational basics. Without delving into the details already covered, let's remember the key function of NAT: it enables a multitude of devices, far exceeding the 2^32 limit, to connect to the internet using 32-bit addressing. NAT achieves this by intelligently using additional packet information at the receiving end to correctly route the data.

### Basically Everything Uses HTTP

HTTP, which stands for HyperText Transfer Protocol, is the backbone of internet connectivity, initially designed for transmitting only text, like the content on this blog page. If we only consider its original intent, it might seem logical to restrict HTTP to text transmission and delegate other tasks to specialized protocols like SSH for computing, FTP for file transfer, and some hypothetical Video Transmission Protocol to transmit videos.

However, in reality, HTTP's application has expanded far beyond its initial design. It is now used for a wide array of tasks: sending files, streaming live videos, and executing commands through RESTful APIs. This versatile usage underscores a recurring theme in technological evolution — using technologies in ways they were not originally intended to be used.

A major reason for HTTP's predominance is its widespread support. Many networks, like the free WiFi at Edinburgh Airport, restrict protocols like SSH or FTP, but not HTTP, as blocking it would render most websites inaccessible. This prevalence makes HTTP a more reliable choice for various internet activities.

Another example of HTTP's reliability over other protocols comes from my experience using **`traceroute`**, a tool that maps the journey of a message across the internet. While its [default ICMP protocol](https://networklessons.com/cisco/ccna-routing-switching-icnd1-100-105/traceroute) often encounters timeouts, indicating blockages, switching to TCP on port 80, which HTTP uses, yielded successful and informative results. This experience highlights HTTP's robustness and wide acceptance in diverse network environments.

### Base64 Encoding

Imagine needing to send an image through a channel that only supports text. This problem can be resolved using Base64 Encoding. This method transforms any arbitrary data into a string of Latin letters, numbers, and select symbols. 

One application of Base64 encoding is in [email digital signatures with GPG](https://unix.stackexchange.com/a/652121). Digital signatures, essentially random data, can be cumbersome to transfer via email. Encoding it with Base64 is a very good hack because it bypasses most email filters, and won't accidentally break email servers or clients that are poorly programmed, not to mention the convenience of copy and paste.

In essence, Base64 encoding is a clever workaround, enabling the transfer of any data type through text-only channels. This method overcomes the limitations of channel compatibility, offering a practical alternative to overhauling communication systems or facing data transfer restrictions. While this approach may introduce some data inefficiency, its benefits in versatility and accessibility are significant.

## TLS 1.3 version number

[Long story](https://blog.cloudflare.com/why-tls-1-3-isnt-in-browsers-yet/) short, TLS 1.3 is the latest iteration of the Transport Layer Security protocol, designed to safeguard internet activities from malicious interception, such as password theft or webpage tampering. However, implementing TLS 1.3 faced unexpected challenges.

The protocol specification includes a field indicating its version. While updating this field to reflect TLS 1.3 seemed straightforward, trials by Chrome and Firefox revealed that it disrupted numerous network connections. The root cause was the incompatibility of some network devices designed to passively listen to and potentially filter traffic, which crash if they even see a number other than 1.2 or smaller in the version field. This is very stupid programming mistake if you ask me, but given TLS 1.2's prolonged dominance the mistake is understandable due to the absence of use cases for versions beyond 1.2.

To resolve this, the Internet Engineering Task Force (IETF) essentially resorted to using a hack. Instead of altering the version number, they moved the version negotiation to an extension. This effectively makes old programs think the connection still uses 1.2 while new programs can look elsewhere to find the true actual version, maintaining backwards compatibility.

## WebSocket

WebSocket, at its core, is functionally similar to TCP, offering full-duplex communication between a client and server. However, WebSocket extends some additional capabilities over standard TCP connections.

One significant advantage of WebSocket is its operation over the same TCP port used by HTTP. This alignment with HTTP's port is highly beneficial, as previously discussed. Leveraging the HTTP port ensures broad support and acceptance, reducing the likelihood of encountering blocks or connectivity issues.

In contrast, utilizing alternative TCP ports often leads to compatibility challenges. Many firewalls and internet service providers, like those managing public WiFi networks (for example, at Edinburgh airport), restrict or block these non-standard ports. This limitation makes WebSocket's compatibility with HTTP's port an essential feature for reliable and accessible web communications.

## Backwards Compatibility Hacks Widens Limited Communication Channels

Conceptually, a protocol essentially describes metadata attached to a message, instructing intermediary systems on the nature of a message and how to handle it without them needing to understand the content of the message. In this view, the backward-compatible changes add new metadata instead of changing the original metadata for new and improved functionality. 

In the context of Network Address Translation (NAT), the strategy is not to modify the IP address format but to use additional internet traffic data to determine the appropriate traffic routing when the IP address alone is insufficient. 

Similarly, in the ubiquitous use of HTTP, the modification isn't in the format of the metadata (HTTP headers), but in altering the content of the data block or the message body.

For Base64 encoding, instead of using binary data that might cause issues in systems with inadequate data processing capabilities, the data is formatted to resemble text, ensuring compatibility with text-processing systems. 

In the case of TLS 1.3, rather than changing the version number, which could confuse older systems, a new field is added to signal the version to newer systems without causing conflicts.

With WebSocket, the innovation lies in not altering the TCP port number but in changing the data transmitted over the TCP connection to mimic different functionalities.

A secondary commonality in these backwards-compatible solutions is their ability to enhance the capabilities of communication channels originally designed for limited functions. NAT expands the number of devices connectable to the internet, Base64 encoding enables different data types to be sent through text-only channels, and WebSocket provides enhanced functionalities without needing port changes.

## Complete Redesign is Also Needed

All of these hacks are clever, but they sometimes come at the cost of efficiency of bandwidth or latency. So there are times when making backwards incompatible change is totally necessary. HTTP/2 is a successful example. It can be faster than its predecessor because it speeds up and optimises the handshake process. This is not possible with a backwards-compatible change because the handshake process can never be replaced in that case. It was quickly adopted and had [68% share of all HTTP traffic](https://blog.cloudflare.com/http3-usage-one-year-on/) in May 2022, which is quite impressive as it was only introduced in 2015.

IPv6 is another example of such backward incompatible change. Although it has found mixed success. I am not very certain about my opinion about it because at least for now, the hacks work and using IPv4 work and switching to IPv6 does not provide much more benefit. However, I have learned something new this week that slightly changed my opinion on this. I might write about this in the next blog post (or not). 

These hacks, while clever, often come with trade-offs in terms of bandwidth efficiency or latency. There are instances where backwards-incompatible changes are beneficial and needed. A prime example is HTTP/2. Introduced in 2015, it marked a significant improvement over its predecessor by optimizing the [connection handshake process](https://sookocheff.com/post/networking/how-does-http-2-work/#inefficient-use-of-tcpip), leading to faster speeds. Such enhancements couldn't have been achieved through backwards-compatible modifications, as they inherently require redefining the handshake process. By May 2022, HTTP/2 had captured an impressive [68% of all HTTP traffic](https://blog.cloudflare.com/http3-usage-one-year-on/), reflecting its rapid adoption and efficiency.

IPv6 presents a different scenario as a backwards-incompatible change. Its success has been mixed, and opinions on its necessity are divided. Currently, the existing 'hacks' with IPv4 are functioning adequately, and the transition to IPv6 doesn't seem to offer substantial benefits in many cases. However, a recent discovery has slightly shifted my perspective on IPv6, which I might explore in my next blog post. The evolution of these technologies underscores the balance between innovation and compatibility in the ever-evolving landscape of internet protocols.
