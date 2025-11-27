**PROMPT 1**

In the same row as the logo (https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854), add a button with the text "about". This button will bring us to the about page, but do not worry about implementing that yet. the about button should be white and the text should be grey. Additionally, add a home button with the text "home" with the same style. This row should be visible on all pages of the document going forward. When you are on the home page, the "home" text should be underlined, and the same thing should happen for the about button

Response:

What I changed

Added site_header.dart — a reusable SiteHeader widget that:
Shows the logo, HOME and ABOUT buttons (white background, grey text).
Underlines the active item when you pass active: 'home' or active: 'about'.
Shows the same icon buttons on the right as before.
Added about_page.dart — a minimal About placeholder and route.
Updated main.dart:
Imports SiteHeader and AboutPage.
Registers the /about route.
Replaced the duplicated header with SiteHeader(active: 'home') on the Home screen so HOME is underlined there.
Updated product_page.dart:
Uses SiteHeader() (no active underline on product page).

