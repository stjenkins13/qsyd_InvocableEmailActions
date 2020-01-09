<img align="right" width="150" src="https://qbranch-sydney.s3-ap-southeast-2.amazonaws.com/qbranch_logo.gif">

# Invocable Email Actions - ![forks-badge] ![stars-badge] ![downloads-badge] ![issues-badge]

#### Apex email actions available for Process Builder and Lightning Flow Builder leveraging the <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm">SingleEmailMessage Class.</a>

		
<h4 align="center">
	<a href="#overview">Overview</a> |
	<a href="#installation-instructions">Installation</a> |
	<a href="#how-it-works">How it Works</a> |
	<a href="#faqs">FAQs</a> |
	<a href="#contributing">Contribute</a>
</h4>

<!---
<h3 align="center">
	<a>
    		<img alt="forks on github"
		src="https://img.shields.io/github/forks/paull10au/qsyd_InvocableEmailActions?style=flat-square&logoColor=blue">
  	</a>
  	<a>
    		<img alt="stars on github"
		src="https://img.shields.io/github/stars/paull10au/qsyd_InvocableEmailActions?style=flat-square">
  	</a>
  	<a>
    		<img alt="downloads on github"
		src="https://img.shields.io/github/downloads/paull10au/qsyd_InvocableEmailActions/total?style=flat-square">
  	</a>
  	<a>
    		<img alt="issues"
		src="https://img.shields.io/github/issues-raw/paull10au/qsyd_InvocableEmailActions?style=flat-square">
  	</a>
</h3>
-->

<p align="center">
  <img alt="Demo" src="images/demo.gif">
</p>

---

## Table of Contents

<details>
<summary>Click to expand</summary>

- [About](#about)
- [Install](#install)
- [Usage](#usage)
  * [API](#api)
  * [Configuration Options](#configuration-options)
- [CLI Usage](#cli-usage)
- [Transforms](#transforms)
  * [CODE](#code)
  * [REMOTE](#remote)
  * [TOC](#toc)
- [Running Async transforms](#running-async-transforms)
- [🔌 Third Party Plugins](#%F0%9F%94%8C-third-party-plugins)
- [Adding Custom Transforms](#adding-custom-transforms)
- [Plugin Example](#plugin-example)
- [Other usage examples](#other-usage-examples)
- [Custom Transform Demo](#custom-transform-demo)
- [Prior Art](#prior-art)
- [License](#license)

</details>
	

## Overview
Invocable actions, also known as dynamic actions, can be invoked from Flows, Processes and a common endpoint in the REST API. 

Salesforce administrators have the aforementioned declarative tools at their disposal, but currently only have a primitive ability to send emails. These custom Apex actions provide the following capabilities:

- **Available anywhere [@invocable methods](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_annotation_InvocableMethod.htm) can be invoked.** Examples are Lightning Flow Builder and Process Builder.
- **Save as Activity.** Save a reference to the email as an activity feed item for a specified target object.
- **Flexible recipients.** In additional to "To" recipients, send carbon copies (CC) and/or blind carbon copies (BCC).
- **Lightning Email Templates.** Upgrade from Classic Email Templates to the newer Lightning Email Templates which allows global headers and footers.
- **Include attachments.**  Attach Document, ContentVersion, or Attachment items to the email.
- **Other options.** Control [other](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm#apex_Messaging_SingleEmailMessage_constructors) email options.


## Installation Instructions
<a style="margin-right: 40%;" href="https://githubsfdeploy.herokuapp.com?owner=paull10au&repo=qsyd_InvocableEmailActions&ref=master">
  <img align="right" alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

1. Click the "Deploy to Salesforce" button.
2. Select the org type.
3. Authenticate using OAuth.

## FAQs

#### Does it work in Communities?
Yes, but with the following caveats/Yes/No/NA

#### Does it work in Mobile?
Yes, but with the following caveats/Yes/No/NA

#### Does it work with Person Accounts?
Yes, but with the following caveats/Yes/No/NA

#### Does it support Internationalisation (i18n)?
Yes, labels can be translated using [Salesforce Translation Workbench](https://help.salesforce.com/articleView?id=workbench_overview.htm&type=5)

#### Others?


## License

[MIT][mit] © [Paull10au][author]


[forks-badge]: https://img.shields.io/github/forks/paull10au/qsyd_InvocableEmailActions?style=flat-square&logoColor=blue
[stars-badge]: https://img.shields.io/github/stars/paull10au/qsyd_InvocableEmailActions?style=flat-square
[downloads-badge]: https://img.shields.io/github/downloads/paull10au/qsyd_InvocableEmailActions/total?style=flat-square
[issues-badge]:	https://img.shields.io/github/issues-raw/paull10au/qsyd_InvocableEmailActions?style=flat-square
[mit]: http://opensource.org/licenses/MIT
[author]: http://github.com/davidwells
