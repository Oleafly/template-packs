#import "/constants.typ": *
#import template: color_palette
#import "@preview/cetz:0.4.2": canvas, draw, palette
#import "@preview/cetz-plot:0.1.2": chart

///! title = "Weak password policy"
///! impact = "Severe"
///! likelihood = "Likely"
///! updates = [
///!    { date = "2023-06-05", notes = "note note note", status = "Open", impact = "Moderate", likelihood = "Possible" },
///!    { date = "2023-06-06", notes = "note note note", status = "Closed", force_display = false },
///! ]

#let domain_name = "domain.com"
#let password_spray = (
    accounts_compromised: 0,
    had_admin_privs: false,
    performed: false
)

#let expiry_days = 90
#let found_cleartext = true

#let cracking_stats = (
    passwords: (total: 1000, unique: 200),
    cracked: (total: 500, unique: 350),
)

#let common_passwords = (
    //password, count
    "Password1", 1337,
    "Password2", 53,
    "Password3", 50,
    "Password4", 12,
)

#let password_lengths = (
    "< 8" : 1,
    "8"   : 5,
    "9"   : 10,
    "10"  : 55,
    "11"  : 1337,
    "12"  : 100,
    "13"  : 43,
    "> 13": 12,
)

<weakpasswordpolicy>

=== Risk assessment

/*
*Example*

#company identified weak passwords that did not meet #client's expected complexity requirements. As users were not forced to reset their passwords after the latest password policy was implemented, many are still using weak and insecure legacy passwords. These passwords are susceptible to guessing or cracking.

An attacker who obtains credentials through cracking (such as capturing password hashes using #link(label("namerespoison"), strong([Name Resolution poisoning]))) or guessing can access #client resources available to that user, including emails, SharePoint, wireless network and server access. 

Additionally, an attacker with valid credentials can launch attacks against #client network that require authentication, such as #link(label("coercedauth"), strong([Coerced Authentication])), which can lead to privilege escalation. 
*/

=== Description

The password policy used at #client does not prevent users from choosing and handling passwords insecurely. User accounts had weak passwords that are vulnerable to brute force and password spray attacks yet give access to sensitive information and administrator privileges.

// Adjust the below if a password spray was not done

#if password_spray.performed {
[
A password spray attack is where the attacker tries one password against multiple accounts.
This is done to prevent account lockout and detection. The consultant performed this attack
during the engagement and successfully compromised #password_spray.accounts_compromised accounts
#if password_spray.had_admin_privs {[, some of which had local administrator privileges on a system]}.
]
}

After gaining Domain Admin rights, the password hashes for all accounts in the #domain_name domain were taken from the NTDS file and were cracked offline using GPU power. The results are shown below:

#table(
    columns: (auto, 1fr, 1fr, 1fr),
    ..heading_style([], [Passwords], [Cracked], [Percentage]),
    [Total], [#cracking_stats.passwords.total], [#cracking_stats.cracked.total], [#repr(calc.round(cracking_stats.cracked.total / cracking_stats.passwords.total * 100, digits: 1))%],
    [Unique], [#cracking_stats.passwords.unique], [#cracking_stats.cracked.unique], [#repr(calc.round(cracking_stats.cracked.unique / cracking_stats.passwords.unique * 100, digits: 1))%],
)

These results show that users are choosing insecure passwords for their accounts and are opting to select the minimum number of characters required by the domain password policy setting. The reasons behind the successful password cracking are likely to be:

1. A weak domain password policy;
2. Use of LM hashes for some accounts;
3. A culture of using 1 dictionary word in passwords;
4. Multiple accounts using the same password;
5. Frequently expiring passwords.

// Check the above for accuracy

#figure(
    //image("screenshots/domain-password-policy.png"),
    [TODO],
    caption: [Password policy],
)

// Use the -history flag with impacket-secretsdump to get password history

Requiring that passwords expire within a short timeframe (in this case, #expiry_days days) overwhelmingly results in users reusing the same password with a simple change, such as incrementing a number on the end of the password. Multiple examples were found by examining the password history of users. A sample are included below:

#figure(
    //image("screenshots/expiry-1.png", width: 50%),
    [TODO],
    caption: [Incrementing number on end of password due to password expiry \#1],
)

#figure(
    //image("screenshots/expiry-2.png", width: 50%),
    [TODO],
    caption: [Incrementing number on end of password due to password expiry \#2],
)

The following are the most used passwords:

#table(
    columns: (1fr, 1fr),
    align: horizon + center,
    ..heading_style([Password], [Count]),
    ..common_passwords.map(x => str(x))
)

This is a breakdown of the length of passwords that were cracked during the engagement time-frame:

#align(center, canvas({
    import draw: *

    let colors = palette.new(colors: (color_palette.at("main").lighten(30%), black))

    // Remove background grid
    set-style(
        grid: (
            stroke: none,
        ),
    )

    chart.columnchart(
        size: (auto, password_lengths.keys().len()),
        mode: "stacked",
        value-key: (1,),
        bar-style: colors,
        y-format: v => [#calc.round(v)],
        {
            let result_data = ()

            for key in password_lengths.keys() {
                result_data.push((key, password_lengths.at(key)))
            }

            //panic(result_data)
           result_data
        },
    )
}))

#if found_cleartext {
    [Multiple passwords were also found to be stored in cleartext in places accessible by anyone with a low privilege account. Their existence shows that there is either no password policy to prevent this, or it is not enforced. Storing password in cleartext makes it easier for attackers to gain access to sensitive information and critical systems.]
}

=== Recommendations

Create or improve your password policy. The following topics should be included as a minimum and tailored towards your company:

1. *Choosing passwords for accounts:* When educating people on password choice, length is more secure than complexity. A password with 16 lowercase characters is more secure than an 8-character password with letter, numbers and special characters. Users should be encouraged to choose a passphrase (rather than a password) consisting of multiple words.

2. *Domain password policy settings:* To encourage choosing passwords like the one above, and for added security against brute force attacks, the following settings are recommended.

#align(center, box(width: 90%, [
  #set align(left)
  #table(
    columns: (2.5fr, 1fr),
    ..heading_style([Policy settings], [Recommended value]),
    [Minimum password length             ], [14                ],
    [Complexity requirement              ], [No                ],
    [Minimum password age                ], [0 days            ],
    [Maximum password age                ], [0 days            ],
    [Account Lockout Threshold           ], [3 attempts        ],
    [Account Lockout Duration            ], [1 hour            ],
    [Reset account lockout counter after ], [30 minutes        ]
)

Note that the *Maximum password age* should be set to 0 so that users are not forced to regularly change their passwords. Recent studies have shown that forcing users to regularly change passwords encourages weaker password choice. However, if a password is thought to be breached, then a new password should still be set. #footnote[https://pages.nist.gov/800-63-3/sp800-63b.html#memsecretver]
]))

3. *Use a password manager:* Random, 32-character passwords are stronger than 16-character passwords but are extremely hard to remember. Using a password manager such as Bitwarden or KeePass allows admins and users to store randomly generated passwords in the vault and retrieve them using one master password. It also discourages the storage of cleartext passwords on systems or in file shares.

4. *Rotate shared account passwords*: Shared accounts should not be used if it can be avoided. There is no audit trail and the passwords are more likely to be leaked. However, for accounts that must be shared, ensure that passwords to these accounts are only viewable to authorised staff and are rotated on a regular basis. Again, a password manager can aid with this.

5. *Do not reuse passwords:* A password should never be used for more than one account. Each account should have a unique password whether that account is a domain account, local account or otherwise. Generating a random password and storing it in a password manager is one way to do this.

#v(0em)


6. *Password audits:* Perform regular password audits by attempting to crack user passwords. Users that choose crackable passwords should be retrained and asked to choose a new password. As an incentive, users who choose secure passwords can be given a reward by the business.

7. *Password filter:* Consider implementing a password filter that prevents users choosing insecure and passwords commonly found in wordlists. This can be done by creating a DLL that is loaded by the LSA service on domain controllers. (More information: https://docs.microsoft.com/en-au/windows/win32/secmgmt/installing-and-registering-a-password-filter-dll)

Staff should be encouraged to follow these policies for both their work and personal account to build strong password habits. They should also be frequently reminded of the policy during security awareness training.

