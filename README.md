# Introduction

This security lab project reaches out and deploys a simple EC2 instance, installing a few basic packages for the learner. The heart is in the [setup.sh](https://github.com/crtcards1/demo_class/blob/main/Scripts/setup.sh), updating and pulling packages. It also pulls down the PCAP used for the scenario. I setup a very simple environment with my [Terraform](https://github.com/crtcards1/demo_class/blob/main/Scripts/main.tf) script allowing the ability to either SSH or RDP into the machine. SSH is more than acceptable to run through this scenario though, utilizing RDP was just a proof of concept. 

---
# Some Environment Setup Notes

Run the [main.tf](https://github.com/crtcards1/demo_class/blob/main/Scripts/main.tf), assuming you already have your aws configured and ready to go. Previous versions of Ubuntu should work without issues, but this was developed with `ubuntu-noble-24.04`.  The ami image used:
```bash
ami-0d1b5a8c13042c939
```

The script will take a few moments to build out the machine and allow the services to start up. After a minute or so, the machine will run [setup.sh](https://github.com/crtcards1/demo_class/blob/main/Scripts/setup.sh), and you can verify output with a:

```bash
sudo tail -f /var/log/user-data.log
```

The end of the script will pull the PCAP file and at this point your read to follow the [Lab Instructions](https://github.com/crtcards1/demo_class/blob/main/Lab%20Guide.md).

### Setup with Terraform/AWS

If you're attempting to duplicate this in your local environment, you'll need one **Ubuntu 24.04 Console** with an `ubuntu` user. Once you have that environment, you can run the [setup.sh](https://github.com/crtcards1/demo_class/blob/main/Scripts/setup.sh) script:
```bash
chmod +x setup.sh
sudo ./setup.sh
```
---

# Learner Instructions

You will need to follow along in the [Lab Instructions](https://github.com/crtcards1/demo_class/blob/main/Lab%20Guide.md)I've provided in this repo. They should be run from the **Ubuntu 24.04 terminal** machine you have set up.



