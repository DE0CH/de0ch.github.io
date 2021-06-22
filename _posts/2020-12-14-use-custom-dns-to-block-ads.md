---
layout: post
title: "Use Ad-blocking DNS to Block Ads everywhere"
---

If you want to block ads everywhere for any device without installing any apps, including in TV boxes and mobile games, you can use a DNS server that blocks ad. Here I go over briefly how you can set it up and how it works.

## Advanced Guide

The DNS server I host is at ip address `14.198.1.214`. It is located in Hong Kong.

## Step by Step
The following is a condensed version of the guide. Depending on the device that you are using, the steps vary. Therefor I am just going to go through the set up procedure for common platforms. Usually the computer will ask for two DNS address, so put the same address for both or leave the second one blank[^why-dns-option].

[^why-dns-option]: WHy not use a back up DNS? When your computer fails to get an IP address from the primary DNS server, it will consult the secondary DNS server. So if your second DNS server does not block ad, ad-blocking would not work. Your computer can still load the ad by using the secondary DNS. 

### For router
I recommend you set it on your router because the changes will also be automatically applied to all the devices connected to the network.
Routers have very different ways to configure and set the DNS server address, so it's better if you Google yourself how to configure for your specific router. 

### For iOS
1. Go to __Settings__.
2. Go to __Wi-Fi__ (it is impossible to set DNS for mobile networks).
3. Tap on the name of the currently active network.
4. In the __DNS__ field enter the address `14.198.1.214`.

### For Android 
1. Go to __Settings__.
2. Go to __Wi-Fi__.
2. Long press on the name of the currently active network and select __Modify Network__. 
4. Find the IP setting (it might be in the __Advanced__ tab), change it from DHCP to Static and change both __DNS 1__ and __DNS 2__ to `14.198.1.214`. 

### For Windows
1. Go to __Control Panel__.
2. Go to __Network and Internet__, and then go to __Network and Sharing Center__.
3. On the left side of the screen, select __Change adapter settings__.
4. Right Click on the network and select __Properties__. 
5. Select __Properties__ for __Internet Protocol Version 4 (TCP/IP)__.
6. Change the __DNS server addresses__ to `14.198.1.214`.

### For Mac OS
1. Go to __System Preferences__.
2. Click on __Network__.
3. Select the first connection in the list on the left, and select __Advanced__.
4. Select the __DNS__ tab and add (and only add) `14.198.1.214`. 

For additional resources, you can google "how to change DNS server on xxx device". 




## DNS Sinkhole 101

### What is a Domain Name System (DNS) Server? 
By the design of internet, computers connected are identified (located) by an IP address. But it became quite annoying to remember the IP address of computers, so born the Domain Name System (DNS) [^dns]. 



[^dns]: Why not just use domain name instead of ip address in the first place? Perhaps it's for backward compatibility. It was originally designed with numbers as IP addresses and we are just stuck with it, just like we are stuck with using numbers instead of username for phones. 


When you go to a website, say [https://google.com](https://google.com), your computer needs to know the IP address of the server (in this case `172.217.161.142`) in order to communicate with the server. Your computer would send a request to the default DNS server to ask for the IP address associated with google.com, then your computer would follow that IP address to request for the webpage. Of course, you don't see the IP address in your address bar because all these happen behind the scene. 

### What is a DNS sinkhole?
A DNS sinkhole is a specially programmed DNS server that does not return you the address of known domain name used to host ads[^ad-dns]. For example `https://acdn.adnxs.com/` is used to exclusively host ads. 

I am (obviously) not the only one providing an DNS sinkhole; AdGuard and many others also provides many[^why-dns].

[^ad-dns]: Luckily most ads are hosted on separate domain names as the main contents. For example, Google hosts some ads under `ads.google.com` and its google search is under `www.google.com`. However, some websites server their content and ads from the same sever such as YouTube and Instagram, in which case the ad blocker would not be able to block them (otherwise it would block the legit contents as well). 

[^why-dns]: So why am I making another one that already exists? The one by ad-guard is in Europe and the latency is high. Mine is in Hong Kong, which is perfect if you live in Hong Kong.

## Privacy Concerns
If you use my DNS ad blocker, does that mean I can see you what you are doing online?
No, because 
1. I have no interest in what you do.
2. I have disabled logging and analytics. completely (to the best of my knowledge). I can only see how many requests I am getting, but not from who. I promise that I will never turn it on because I don't believe in tracking. 
3. I am unable to. The webpages you visit are encrypted and the connection doesn't even go through the server. The server only receives the domain name, not even the entire url. 

## Make your own DNS server with pi-hole
A "server" sounds intimidating but it actually is not. It requires nothing more than a computer (no matter how slow or cheap because DNS server virtually takes no power). You can make one yourself if you want more speed and control over your network. Just go to [pi-hole.net](https://pi-hole.net) to learn how to set up. Linus Tech Tips also made an [excellent tutorial](https://youtu.be/KBXTnrD_Zs4) on that. 

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

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" />