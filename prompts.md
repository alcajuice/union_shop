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

**PROMPT 2**

Can you center the home and about buttons on the row at the top of every page. Make sure to keep the magnify glass, user icon and shopping pag icon on the right side, only move the text buttons to the center

I've centered the HOME and ABOUT text buttons in the header while keeping the logo on the left and the icon buttons on the right.

What I changed

Edited site_header.dart:
Replaced the inline placement of the Home and About buttons with an Expanded(child: Center(child: Row(...))). This centers the two text buttons between the left logo and the right icons.
Kept the logo, icon buttons, and existing styles/underline behavior intact.
How this behaves

The logo stays left-aligned.
The HOME and ABOUT buttons appear centered in the header row.
The icons (search, user, cart, menu) remain right-aligned.
The active underline still works by passing active: 'home' or active: 'about' to SiteHeader.

**PROMPT 3**

At the bottom left of the about us page, add some information. We need to include information such as Opening Hours. Text should include 
"Opening Hours

❄️ Winter Break Closure Dates ❄️
Closing 4pm 19/12/2025
Reopening 10am 05/01/2026
Last post date: 12pm on 18/12/2025
------------------------
(Term Time)
Monday - Friday 10am - 4pm
(Outside of Term Time / Consolidation Weeks)
Monday - Friday 10am - 3pm
Purchase online 24/7"

Response:

I added an "Opening Hours" section at the bottom of the About page and kept only that column (omitting the other footer columns).

Files changed

Updated about_page.dart — appended a footer-like Container with the Opening Hours content:
Heading: Opening Hours
Winter break closure dates, closing/reopening dates, last post date
Term time hours and outside-term hours
"Purchase online 24/7"
Notes

The section uses Colors.grey[100] background and padding to visually resemble a footer area.
Text styles are simple (bold for important lines, italic for contextual notes). I used a small dividing line string to match the screenshot; if you'd like a separator line widget, I can switch to Divider().

**PROMPT 4**

This footer should be visible on every page. Can you copy this footer onto the main store page as well, and whenever we add more pages, make sure to add the footer

What I changed

Added site_footer.dart — a new SiteFooter widget that contains the "Opening Hours" content.
Replaced the inline Opening Hours container in about_page.dart with const SiteFooter().
Replaced the placeholder footers in main.dart and product_page.dart with const SiteFooter().
Imported site_footer.dart where needed.
How it behaves

The same Opening Hours footer now appears on Home, Product, and About pages.
Future pages can reuse the footer by importing package:union_shop/widgets/site_footer.dart and adding const SiteFooter() at the bottom of their content.
Optional improvements I can make

Make the footer a responsive multi-column layout (Opening Hours + Help + Latest Offers) that collapses to a single column on narrow screens.
Replace the ASCII separator with Divider() and better spacing.
Extract the opening hours content into a data structure or localization file if you plan to update it often.

**PROMPT 5**

In the middle of the footer, add the title "Help and Information" in the same style as "Opening Hours". Underneath this title, instead of displaying information, create two buttons stacked vertically on top of each other. On top, the button should say "search", which will send the user to a search page (can be a placeholder). The secondd button should say "Terms & Conditions of Sale Policy", which will not have an output.

