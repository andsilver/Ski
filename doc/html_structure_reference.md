# HTML Structure Reference

This document is a general reference for anyone wanting to script or style
the HTML produced by this application.

## Part of the Main Layout

* `div#admin_bar` contains a menu which is displayed when an administrator
  is logged in.
* `div#wrapper` wraps everything within the body on every page. It is
  currently used to display the header image but this will change.
* `li.flag_XX` is used for country navigation where XX is the ISO country
  code.
* `nav#main_menu` is the main menu for general site areas.
* `nav#browse` is the menu for navigating resort content and is
  likely to change drastically.
* `div#content` holds the bulk of the page content -- the content that
  changes between pages.
* `footer` is only used once and is used for the main site footer.

## Found Frequently

* `div#error_explanation` appears above forms that have failed to validate
  and surrounds an `<h2>` and a list of error messages.
* `div.field` surrounds most form fields.
* `div.field_with_errors` appears inside `div.field` when the field contains
  validation errors.
* `p.clear` is used to clear leading floating elements
* `span.km` surrounds the letters 'km' when displaying distances.
* `span.required` surrounds an asterisk after a required form field.
* `td.numeric` for table cells containing numeric data (numbers, prices,
  distances).
* `td.price` for table cells containing prices

## Forms

Each form for creating a new object has the selectors `form.new_objectname`
and `form#new_objectname`. Existing object names are:

* category
* country
* coupon
* directory_advert
* enquiry
* property
* resort
* role
* user

When the form is used for editing the selectors become form.edit_objectname
and form#edit_objectname_X where X is the ID of the object being edited.
As the ID changes you would use the form.edit_objectname for applying CSS.

## Pagination

Page navigation used on search results that are displayed over a number of
pages.

* `.pagination`
* `.pagination a`
* `.pagination em`
* `.pagination span`
* `.pagination span.disabled`
* `.pagination .page_info`
* `.pagination .next_page`
* `.pagination .previous_page`

## Categories

### categories/_form.html.erb

* `form.new_category` and `form#new_category`
* `form.edit_category` and `form#edit_category_X`
* `input#category_name`
* `input#category_resort_id`
* `input#category_submit`

### categories/show.html.erb

* `table#directory_adverts`

## Properties

### properties/_my_details_summary.html.erb

An area that reminds the advertiser of their current details in the context
of the new advert, prompting the advertiser to update them if necessary.

* `#my_details_summary`
* `#general_address`
* `#billing_address`
* `label.filter` for search filter checkboxes and their labels

### properties/show.html.erb

* `p#property_main_image`
  Surrounds the main property `<img>`
* `form.new_enquiry` and `form#new_enquiry`
* `input#enquiry_name`
* `input#enquiry_email`
* `input#enquiry_phone`
* `input#enquiry_postcode`
* `input#enquiry_submit`
* `span#current_time` is where Javascript puts a hidden input field inside
  with the current time. This is part of the spam protection.

## Resorts

### resorts/_form.html.erb

* `input#resort_name`
* `input#resort_country_id`
* `textarea#resort_info`

## Routes

This is a list of pages in the website.

<pre>
/advertise
/basket
/countries
/countries/new
/countries/:id/edit
/countries/:id
/coupons
/coupons/new
/coupons/:id/edit
/directory_adverts/my
/directory_adverts
/directory_adverts/new
/directory_adverts/:id/edit
/directory_adverts/:id
/enquiries/current_time
/enquiries/my
/enquiries
/enquiries/new
/enquiries/:id/edit
/enquiries/:id
/export
/export/spreadsheet
/images
/images/new
/images/:id/edit
/images/:id
/my/details
/my/properties/for_rent
/my/properties/for_sale
/new-developments
/orders/latest_receipt
/orders/receipts
/orders/select_payment_method
/orders/:id/receipt
/orders
/orders/new
/orders/:id/edit
/properties/rent
/properties/sale
/properties/current_time
/properties
/properties/new
/properties/:id/edit
/properties/:id
/resorts/:id/properties/rent
/resorts/:resort_id/categories
/resorts/:resort_id/categories/new
/resorts/:resort_id/categories/:id/edit
/resorts/:resort_id/categories/:id
/resorts/:id/info
/resorts
/resorts/new
/resorts/:id/edit
/resorts/:id
/roles
/roles/new
/roles/:id/edit
/sessions
/sessions/new
/sessions/:id/edit
/sessions/:id
/sign_in
/sign_out
/sign_up
/users
/users/new
/users/:id/edit
/users/:id
/websites/:id/edit
/
</pre>
