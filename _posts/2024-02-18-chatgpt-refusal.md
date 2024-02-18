---
layout: post
title: "ChatGPT frequent requests refusals"
---

Recently, I was trying to investigate printing works at my university. I know it sends files with some protocol over https because I had to input some http url into a system dialogue to add the printer, as well as my university email and password, but I was not sure how it works exactly.

I was particularly interested in knowing how it handles authentication and if there's any vulnerability that can lead to users' email and password being stolen. I used Wireshark to analyse the traffic and found out it was encrypted with TLS.

So I needed to find a way to decrypt the message. After some Googling, I found that I could use the [SSLKEYLOGFILE environment variable](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA14u000000HB8gCAG&lang=en_US%E2%80%A9) when using applications like Google Chrome, which basically tells the app to write the encryption key along with some other information into a file so that Wireshark can use it later to decrypt that traffic. The app then writes information like the private key into the file so that network traffic analyzers like Wireshark can decrypt the SSL traffic.

This method works with browsers, but since the printing was probably initiated by some system process, I didn't know how to pass environment variables to them and even if I could, I was not sure if they would respect the environment variable.

Google didn't immediately return any useful result, so I did the next best thing I could do, I asked ChatGPT. I told it I wanted to achieve something similar to SSHKEYLOGFILE for Chrome but for the entire system. To my utter surprise, ChatGPT refused my request saying it was unethical and illegal. I knew that ChatGPT refuses to assist with actually committing illegal activities, but what I was trying to do was far from illegal or ethical.

## ChatGPT Refused requests

This led me to test if it would refuse more requests that are not illegal at all. Here are some examples of refused request

- **Fork Bomb:** I asked ChatGPT why my fork bomb does not work in Python. It refused to answer me as well, citing that it can "cause serious harm".
- **Reverse Shell:** I asked it how to use a reverse shell. It refused with the classic "I'm sorry, but I can't assist with that." This was complete nonsense because the prerequisite for using these techniques is that an attacker gains arbitrary code execution on a system and by that time, the system is totally compromised. By that time you have much bigger problems than a fork bomb.

Intriguingly, as I was writing this, I tried to ask it about reverse shell again, two weeks after it initially denied my request and it actually answered me with helpful basic information, including commands to launch it (though I didn't test if it works).

## Degree of safety

Since LLMs are generated on a vast number of sources on the internet, which, mind you, has everything. There are obviously many things that are off-limit/illegal/unethical. So it's important to moderate it, or as OpenAI calls it "safety and alignment". Safety and alignment basically consist of rejecting certain requests and making sure its output doesn't contain certain information, like how to cook meth.

But taken to the extreme, it stops the spread of useful information and knowledge. For example, telling people about cybersecurity might be useful for hackers but also useful for those who are interested in knowing how computer systems work and how they can defend themselves from attacks. Crucially, cybersecurity is freely discussed on the internet and search engines like Google return useful results and learning about them is not illegal or unethical in any sense.

## Refusal doesn't even work

Refusing to answer cybersecurity-related questions doesn't help with preventing them from happening. This is because actual hackers have much better tools. They can also use a plethora of open-source models (or even train one themselves) that don't have such restrictions. e.g. [dolphin-mixtral](https://ollama.com/library/dolphin-mixtral). Unsurprising, it tells you how to cook meth. Setting it up wasn't even difficult, and required nothing except for a decently powerful GPU like Nvidia RTX 3080. Actual well-sponsored hacker groups undoubtedly would have much better tools and resources, so ChatGPT refusing these requests would accomplish nothing much other than stopping curious individuals learning about cybersecurity.

## Printer protocol

After some intensive Googling and document reading, I found out the [transparency mode in mitmproxy](https://docs.mitmproxy.org/stable/howto-transparent/) was exactly what it needed. I set it up and successfully, captured, and decrypted the traffic. It turns out there is nothing special with the authentication protocol; it just sends the username and password as plaintext in the HTML header. Luckily, the traffic is encrypted with TLS. Still, I think there are better ways like using OAuth in case the traffic gets intercepted when decrypted somewhere else or when the private TLS key is leaked, but that's probably for next time.
