# Goof - Snyk's vulnerable demo app repo
[![Known Vulnerabilities](https://snyk.io/test/github/snyk/goof/badge.svg?style=flat-square)](https://snyk.io/test/github/snyk/goof)

Welcome to the Snyk "Goof" vulnerable demo application repo.
This repository contains a pair of purposefully vulnerable applications used for the purpose of demonstrating Snyk's capabilities in finding and fixing vulnerabilities in your dependencies and container images.
This repo is used as part of several Snyk Snyk workshops including:
* https://container-security-snyk.awsworkshop.io/
* https://snyk-labs.github.io/snyk-gcp-container-live-hack

---
## WARNING! | ACHTUNG! | ¡PRECAUCIÓN! | !AVERTISSEMENT!
Many of the applications that are part of this workshop are **highly dangerous**
and are purposely built with vulnerabilities! Please, **do not deploy these examples to
clusters that you don't want to have attacked!**

In other words, only deploy these to local/sandboxed clusters for the sole purpose of experimentation.
Examples of places you should **NOT** deploy this to:
* your developer servers
* your QA environment
* your company's cloud account

We take no responsibility for exploitation or damages caused by deploying anything from this
repository (or the associated container images) to your personal or organization's infrastructure (private or public).

## You have been warned!

---

### Contents
Applications included in this repo:
* [thumbnailer](thumbnailer) - Python application deployed in a container who's base image contains a vulnerable version of ImageMagick.
* [todolist](todolist) - Java JEE application with many vulnerable dependencies, including the Log4Shell vulnerability and an implementation of a malicous LDAP server for exploting it.

_Note: This README is a WIP, and will be updated with more information soon._


