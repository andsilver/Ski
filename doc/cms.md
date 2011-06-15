CMS User Guide
==============

Resizing Images
---------------

Get IrfanView from http://www.irfanview.com/

Open images in IrfanView

Use Image > Scale (or Resize) image

Save a copy of the image (Save As) as a .jpg

Naming Files
------------

The web server is case sensitive: CHALET.jpg is not the same as chalet.jpg

It is easier to always use lowercase.

Use hyphens instead of spaces.

Instead of: a chalet.jpg

Use: a-chalet.jpg

HTML
----

Most content can be entered using the Visual mode of the text editor.

Sometimes you will need to click on the Source view to edit the HTML.

To enter an image:

First upload it using CMS > Uploads.

Browse for the image on your computer and press Upload.

Now go to the area in the CMS where you can edit your content.

Let's say you upload an image called chalet.jpg. This is the HTML code to
embed it in the page:

<pre>
&lt;img src="/uploads/chalet.jpg" alt="A chalet"&gt;
</pre>

To position the image on the right:

<pre>
&lt;p class="image_right"&gt;
  &lt;img src="/uploads/chalet.jpg" alt="A chalet"&gt;
&lt;/p&gt;
</pre>

Centre:

<pre>
&lt;p class="image_centre"&gt;
  &lt;img src="/uploads/chalet.jpg" alt="A chalet"&gt;
&lt;/p&gt;
</pre>

Left:

<pre>
&lt;p class="image_left"&gt;
  &lt;img src="/uploads/chalet.jpg" alt="A chalet"&gt;
&lt;/p&gt;
</pre>

Promotion Codes
---------------

Create a new promotion code in CMS > Promotion Codes

Set the number of adverts to which the promotion code can apply (counted from
the first advert placed, regardless of whether it was discounted at the
time).

Set a percentage off. 100% is free.

Apply a promotion code by going to CMS > Users > Some User and changing the
applied promotion code in the drop down menu and then press save.

A promotion code will apply to any kind of advert and all promotion codes
appear in the same area. Prefixing the promotion code with a 'B' for banner
advert or a 'P' for property can aid in reminding what the promotion code
was intended for and also makes it easier to locate alphabetically in the
drop down list.
