---
layout: post
title: "Use Ad-blocking DNS to Block Ads everywhere"
---

If you want to block ads everywhere for any device without installing any apps, including in TV boxes and mobile games, you can use a DNS server that blocks ad. 

## Advanced Set Up

The DNS server I host is at ip address `18.163.112.19`. It is located in Hong Kong.

## Step by step Guide
I am (obviously) not the only one providing an ad-blocking DNS server; [AdGuard](https://adguard.com/) also provides one[^why-dns]. You can follow their well-written [guide](https://adguard.com/en/adguard-dns/overview.html), just replace their dns IP address (`94.140.14.14`, `94.140.15.15`, etc) with the one provided above.

The following is a condensed version of the guide. Depending on the device that you are using, the steps vary. Therefor I am just going to go through the set up procedure for common platforms. Usually the computer will ask for two DNS address, so put the same address for both or leave the second one blank[^why-dns-option].

[^why-dns-option]: WHy not use a back up DNS? When your computer fails to get an IP address from the primary DNS server, it will consult the secondary DNS server. So if your second DNS server does not block ad, ad-blocking would not work. Your computer can still load the ad by using the secondary DNS. 

### For router
I recommend you set it on your router because the changes will also be automatically applied to all the devices connected to the network.
Routers have very different ways to configure and set the DNS server address, so it's better if you Google yourself how to configure for your specific router. 

### For iOS
1. Go to __Settings__.
2. Go to __Wi-Fi__ (it is impossible to set DNS for mobile networks).
3. Tap on the name of the currently active network.
4. In the __DNS__ field enter the address `18.163.112.19`.

### For Android 
1. Go to __Settings__.
2. Go to __Wi-Fi__.
2. Long press on the name of the currently active network and select __Modify Network__. 
4. Find the IP setting (it might be in the __Advanced__ tab), change it from DHCP to Static and change both __DNS 1__ and __DNS 2__ to `18.163.112.19`. 

### For Windows
1. Go to __Control Panel__.
2. Go to __Network and Internet__, and then go to __Network and Sharing Center__.
3. On the left side of the screen, select __Change adapter settings__.
4. Right Click on the network and select __Properties__. 
5. Select __Properties__ for __Internet Protocol Version 4 (TCP/IP)__.
6. Change the __DNS server addresses__ to `18.163.112.19`.

### For Mac OS
1. Go to __System Preferences__.
2. Click on __Network__.
3. Select the first connection in the list on the left, and select __Advanced__.
4. Select the __DNS__ tab and add (and only add) `18.163.112.19`. 

[^why-dns]: So why am I making another one that already exists? The one by ad-guard is in Europe and the latency is high. Mine is in Hong Kong, which is perfect if you live in Hong Kong.


## DNS Sinkhole 101

### What is a Domain Name System (DNS) Server? 
By the design of internet, computers connected are identified (located) by an IP address. But it became quite annoying to remember the IP address of computers, so born the Domain Name System (DNS) [^dns]. 

[^dns]: Why not just use domain name instead of ip address in the first place? Perhaps it's for backward compatibility. It was originally designed with numbers as IP addresses and we are just stuck with it, just like we are stuck with using numbers instead of username for phones. 

When you go to a website, say [https://google.com](https://google.com), your computer needs to know the IP address of the server (in this case `172.217.161.142`) in order to communicate with the server. Your computer would send a request to the default DNS server to ask for the IP address associated with google.com, then your computer would follow that IP address to request for the webpage. Of course, you don't see the IP address in your address bar because all these happen behind the scene. 

### What is a DNS sinkhole?
A DNS sinkhole selectively returns the IP address of Domain Names, in that it will not give you the ip address of a known domain name used to host ads[^ad-dns]. For example `https://acdn.adnxs.com/` is used to exclusively host ads. 

[^ad-dns]: Luckily most ads are hosted on separate domain names as the main contents. For example, Google hosts some ads under `ads.google.com` and its google search is under `www.google.com`. However, some websites server their content and ads from the same sever such as YouTube and Instagram, in which case the ad blocker would not be able to block them (otherwise it would block the legit contents as well). 

## Privacy Concerns
If you use my DNS ad blocker, does that mean I can see you what you are doing online?
No, because 
1. I have no interest in what you do.
2. I have disabled logging and analytics. completely (to the best of my knowledge). I can only see how many requests I am getting, but not from who. I promise that I will never turn it on because I don't believe in tracking. 
3. Even if am evil and wants to track you, I would not be able to. You would only send me the domain name. For example, if you search something on Google, I would only know you've searched for _something_ on Google, but I won't know the exact search terms.

## Make your own DNS server with pi-hole
I essentially made a DNS server with pi-hole, hosted on a Raspberry Pi, and exposed the server to the internet. You can do the same, if you want more speed and control over your network. Just go to [pi-hole.net](https://pi-hole.net) to learn how to set up. Linus Tech Tips also made an [excellent tutorial](https://youtu.be/KBXTnrD_Zs4) on that. 

## Disclaimer

In short: I don't guarantee it will work so please don't sue me if it doesn't.

In long: 

```
THE SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE PROVIDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SERVICES.
```

# Acknowledgement

I used [pi-hole](https://pi-hole.net/) as the DNS snikhole, running on a Raspberry Pi. I used Google DNS as the upstream DNS server. The block lists I used are 
```
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://mirror1.malwaredomains.com/files/justdomains
```

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.