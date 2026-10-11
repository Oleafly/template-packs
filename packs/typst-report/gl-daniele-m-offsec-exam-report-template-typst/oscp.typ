#import "template/offsec_exam_report_template.typ" : *

#let document_title = "OffSec Certified Professional"
#let document_subtitle = "Exam Report"
#let student_email = "student@offsec.com"
#let student_osid = "1337"
#let student_name = "Joe"

//Set document metadata
#set document(
    title: document_title + " - " + document_subtitle,
    author: student_email + ", OS-" + student_osid
)

//Load the template
#show: doc => offsec_exam_report(
    title: document_title,
    subtitle: document_subtitle,
    header_title: "OSCP Exam Report | OS-" + student_osid,
    osid: student_osid,
    email: student_email,
    date: datetime(month: 1, day: 1, year: 2024),
    titlepage_color: rgb("#e66124"),
    link_color: rgb("#e66124"),
    logo: "./logos/PEN-200.svg",
    logo_size: 80pt,
    body: doc
)

//Document body
= #document_subtitle
== Introduction
The #document_title exam report contains all efforts that were conducted in order
to pass the exam. This report will be graded from a standpoint of correctness and
fullness to all aspects of the exam. The purpose of this report is to ensure that the student has a full
understanding of penetration testing methodologies as well as the technical knowledge to pass the exam.

== Objective
The objective of this assessment is to perform an internal penetration test against Offensive Security
Exam network. The student is tasked with following methodical approach in obtaining access to the
objective goals. This test should simulate an actual penetration test and how you would start from
beginning to end, including the overall report. An example page has already been created for you at
the latter portions of this document that should give you ample information on what is expected to
pass this course. Use the sample report as a guideline to get you through the reporting.

== Requirements
The student will be required to fill out this penetration testing report fully and to include the following
sections:
- Overall High-Level Summary and Recommendations (non-technical)
- Methodology walkthrough and detailed outline of steps taken
- Each finding with included screenshots, walkthrough, sample code, and proof.txt if applicable
- Any additional items that were not included

#pagebreak()

= High-Level Summary

#student_name was tasked with performing an internal penetration test towards Offensive Security
Exam network.
An internal penetration test is a dedicated attack against internally connected systems. The focus of
this test is to perform attacks, similar to those of a hacker and attempt to infiltrate Offensive Security’s
internal lab systems - the #text(fill: rgb("#8B0000"))[WHATEVER.LOCAL] domain. #student_name’s overall objective was to evaluate the network,
identify systems, and exploit flaws while reporting the findings back to Offensive Security.
When performing the internal penetration test, there were several alarming vulnerabilities that were
identified on Offensive Security’s network. When performing the attacks, #student_name was able to gain access
to multiple machines, primarily due to outdated patches and poor security configurations. During
the testing, #student_name had administrative level access to multiple systems. #text(fill: rgb("#8B0000"))[All systems were successfully
exploited and access granted]. These systems as well as a brief description on how access was obtained
are listed below:

- Active Directory Set:
    - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit
    - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit
    - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit
- Standalone 1 - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit
- Standalone 2 - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit
- Standalone 3 - #text(fill: rgb("#8B0000"))[HOSTNAME] - Name of initial exploit

== Recommendations
#student_name recommends patching the vulnerabilities identified during the testing to ensure that an attacker
cannot exploit these systems in the future. One thing to remember is that these systems require
frequent patching and once patched, should remain on a regular patch program to protect additional
vulnerabilities that are discovered at a later date.

#pagebreak()

= Methodologies
#student_name utilized a widely adopted approach to performing penetration testing that is effective in testing how well
the Offensive Security Exam environments is secured. Below is a breakout of how #student_name was able to identify and exploit
the variety of systems and includes all individual vulnerabilities found.

== Information Gathering
The information gathering portion of a penetration test focuses on identifying the scope of the pene-
tration test. During this penetration test, #student_name was tasked with exploiting the lab and exam network.
The specific IP addresses were:

#text(fill: rgb("#8B0000"))[
192.168.x.x, 192.168.x.x, 192.168.x.x, 192.168.x.x, 192.168.x.x, 192.168.x.x
]

== Service Enumeration
The service enumeration portion of a penetration test focuses on gathering information about what
services are alive on a system or systems. This is valuable for an attacker as it provides detailed
information on potential attack vectors into a system. Understanding what applications are running
on the system gives an attacker needed information before performing the actual penetration test. In
some cases, some ports may not be listed.

== Penetration
The penetration testing portions of the assessment focus heavily on gaining access to a variety of
systems. During this penetration test, #student_name was able to successfully gain access to #text(fill: rgb("#8B0000"))[*5*] out of the #text(fill: rgb("#8B0000"))[*5*]
systems.

== Maintaining Access
Maintaining access to a system is important to us as attackers, ensuring that we can get back into
a system after it has been exploited is invaluable. The maintaining access phase of the penetration
test focuses on ensuring that once the focused attack has occurred (i.e. a buffer overflow), we have
administrative access over the system again. Many exploits may only be exploitable once and we may
never be able to get back into a system after we have already performed the exploit.
#student_name added administrator and root level accounts on all systems compromised. In addition to the
administrative/root access, a Metasploit meterpreter service was installed on the machine to ensure
that additional access could be established.

== House Cleaning
The house cleaning portions of the assessment ensures that remnants of the penetration test are
removed. Often fragments of tools or user accounts are left on an organizations computer which
can cause security issues down the road. Ensuring that we are meticulous and no remnants of our
penetration test are left over is important.
After the trophies on the exam network were completed, #student_name removed all user accounts and passwords
as well as the meterpreter services installed on the system. Offensive Security should not have to
remove any user accounts or services from the system.
#pagebreak()

//--- End of introduction ---------------------------------

//--- Target 1 ---------------------------------------------

= Target 1 -- 192.168.X.X

== Proof of Exploitation

Interactive shell.
#picture("template/sample_data/sample_proof.png", "Proof of exploitation")

== Service Enumeration
#lorem(120)
\
#let results = csv("template/sample_data/sample.csv")
#align(
    center,
    table(
        align: left,
        stroke: .5pt + black,
        columns: (1fr, 5fr),
        [*Port*], [*Service*],
        ..results.flatten(),
    )
)

== Initial Access
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("Critical") 9.6, CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:L

#lorem(50)

=== Steps to Reproduce
#lorem(150)
#terminal_window[#read("template/sample_data/sample_cmdline_1.log")]

=== Vulnerability Fix
#lorem(20)

== Privilege Escalation
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("high") 8.4, CVSS:3.1/AV:L/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H

#lorem(50)

=== Steps to Reproduce
#lorem(300)
#terminal_window[#read("template/sample_data/sample_cmdline_2.log")]

=== Vulnerability Fix
#lorem(20)

== Post Exploitation
#lorem(120)

#pagebreak()

//--- Target 2 ---------------------------------------------

= Target 2 -- 192.168.X.X

== Proof of Exploitation

Interactive shell.
#picture("template/sample_data/sample_proof.png", "Proof of exploitation")

== Service Enumeration
#lorem(120)
\
#let results = csv("template/sample_data/sample.csv")
#align(
    center,
    table(
        align: left,
        stroke: .5pt + black,
        columns: (1fr, 5fr),
        [*Port*], [*Service*],
        ..results.flatten(),
    )
)

== Initial Access
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("Critical") 9.6, CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:L

#lorem(50)

=== Steps to Reproduce
#lorem(150)
#terminal_window[#read("template/sample_data/sample_cmdline_1.log")]

=== Vulnerability Fix
#lorem(20)

== Privilege Escalation
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("High") 8.4, CVSS:3.1/AV:L/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H

#lorem(50)

=== Steps to Reproduce
#lorem(150)
#terminal_window[#read("template/sample_data/sample_cmdline_2.log")]

=== Vulnerability Fix
#lorem(20)

== Post Exploitation
#lorem(120)

#pagebreak()

//--- Target 3 ---------------------------------------------

= Target 3 -- 192.168.X.X

== Proof of Exploitation

Interactive shell.
#picture("template/sample_data/sample_proof.png", "Proof of exploitation")

== Service Enumeration
#lorem(120)
\
#let results = csv("template/sample_data/sample.csv")
#align(
    center,
    table(
        align: left,
        stroke: .5pt + black,
        columns: (1fr, 5fr),
        [*Port*], [*Service*],
        ..results.flatten(),
    )
)

== Initial Access
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("Critical") 9.6, CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:L

#lorem(50)

=== Steps to Reproduce
#lorem(150)
#terminal_window[#read("template/sample_data/sample_cmdline_1.log")]

=== Vulnerability Fix
#lorem(20)

== Privilege Escalation
#lorem(120)

=== Vulnerability Description

// Get CVSS from CVE information or calculate at https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
// #severity("High") 8.4, CVSS:3.1/AV:L/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H

#lorem(50)

=== Steps to Reproduce
#lorem(150)
#terminal_window[#read("template/sample_data/sample_cmdline_2.log")]

=== Vulnerability Fix
#lorem(20)

== Post Exploitation
#lorem(120)

#pagebreak()

//--- Appendices ------------------------------------------

= Appendices

== Appendix: Local and Proof list

Complete list of local and proof flags:

#table(
    align: center,
    stroke: .5pt + black,
    columns: (1fr, 1fr, 2fr),
    [192.168.X.X],[local.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [192.168.X.X],[proof.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [192.168.X.X],[local.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [192.168.X.X],[proof.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [192.168.X.X],[local.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [192.168.X.X],[proof.txt],[8891ea8df79a98de4b13ebcfcde7f37c],
    [...],[...],[...]
)

== Appendix: Ruby code for exploit X

Ruby code sample for exploit X:

//https://github.com/KINGSABRI/CVE-in-Ruby/blob/master/CVE-2018-7600/cve-2018-7600_exploit.rb
#let exploit_1 = read("template/sample_data/sample_exploit_1.rb")
#codeblock[#raw(exploit_1, lang: "ruby")]

== Appendix: Python code for exploit Y

Python code sample for exploit Y:

//https://www.exploit-db.com/exploits/49908
#let exploit_2 = read("template/sample_data/sample_exploit_2.py")
#codeblock[#raw(exploit_2, lang: "python")]
