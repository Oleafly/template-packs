#import "../lib.typ": *

= Listings <app:listings>

// Beispielhafte Listing-Einträge für den Anhang
// Wenn kein Anhang für Listings benötigt wird, kann die Datei und der Import gelöscht werden

#breakable-code-listing(
  caption: [Exemplary API-Request],
  label: <lst:apiRequest>,
  ```html
export async function Login(name: string, pw: string): Promise<Response> {
    const response = await fetch(`${baseUrl}/api/auth/login`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            name,
            pw,
        }),
    });
    return response;
}
  ```,
)

#breakable-code-listing(
  caption: [Import Website Tracker Code],
  label: <lst:trackerImport>,
  ```text
<script 
    defer 
    src="http://localhost:3333/script.js" 
    data-website-id="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx">
</script>
  ```,
)
