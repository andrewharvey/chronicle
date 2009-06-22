

<!-- tmpl_if name='comments' -->


<h3 id="comments">Comments On This Entry</h3>
<ol class="commentlist">

<!-- tmpl_loop name='comments' -->
<li class="commento alt <!-- tmpl_if name='author' --> author<!-- /tmpl_if -->">
<img alt="[gravitar]" src="<!-- tmpl_var name='gravitar' -->" class="avatar" height="32" width="33" />
<!-- tmpl_if name='link' -->
<cite><a href="<!-- tmpl_var name='link' -->"><!-- tmpl_var name='name' --></a></cite>
<!-- tmpl_else name='link' -->
<cite><!-- tmpl_var name='name' --></cite>
<!-- /tmpl_if name='link' -->
<small class="commentmetadata" style="text-align: right;"><!-- tmpl_var name='date' --></small>

<div class="commentbody">
<!-- tmpl_var name='body' -->
</div>
<!-- /tmpl_loop -->
</ol>

<!-- /tmpl_if -->
