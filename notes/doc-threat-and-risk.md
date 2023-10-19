tags: #documentation #cybersec

Threat analysis
========================

A threat analysis is a process used to determine which components of
the system need to be protected and the types of security risks
(threats) they should be protected from.

1. identify assets which needs protection
2. imagine possible violation scenarios and describe the impact
3. collect threats, identify exposure and exploitability
4. calculate threat risk levels by combining likelihood and impact
5. plan mitigtaion for threats with high risk

System modeling
---------------

Identify system boundaries, describe intended operational environment.

Illustrate with a context block diagram.

Impact modeling
---------------

The goal is to collect system assets, and fill in the impact matrix: describe
the impact of a security property violation.

Basic tenets (CIA) or protection goals are:

- confidentiality
- integrity
- availability

**IMPACT CATEGORIES**

- human health or environmental damage
- disruption of customer business
- breaches of legal or regulatory requirements
- breaches of contractual requirements
- loss of intellectual property, licence fraud
- loss of reputation, customer or market share

**IMPACT SCALE**

- disastrous
- critical
- moderate
- negligible

**PROTECTION GOALS**

- confidentiality
- integrity
- availability

**PROTECTED ASSETS AND SERVICES**

- eg. credentials, sensitive data, software ip, etc.

Component description
---------------------

List hardware and software components and describe potential violation
scenarios for each protection goal and assign an impact rating.

- component
- description
- violation scenarios - CIA

Threat and risk list
--------------------

Describe attack scenarios:

- affected component
- attack description
- protection goal (confidentiality, integrity or availability)
- the associated type of attacker (malicious user, hacker, researcher, etc.)
- the related exploitable weakness and its exposure, exploitability/simplicity and impact
- the risk calculated from the properties of the weakness
- possible security measures, ideas

