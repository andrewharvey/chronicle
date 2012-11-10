<!-- tmpl_if name='calendar' -->
  <!-- tmpl_var name='calendar_month' -->
<!-- /tmpl_if name='calendar' -->

<!-- tmpl_if name='datecloud' -->
<h2>Archive</h2>
<ul>
<!-- tmpl_loop name='datecloud' -->
<li><!-- tmpl_var name='year' -->
<ul>
<!-- tmpl_loop name='months' -->
<li><a href="<!-- tmpl_var name='top' -->archive/<!-- tmpl_var name='year' -->/<!-- tmpl_var name='month' -->/"><!-- tmpl_var name='month_name' escape='html' --> (<!-- tmpl_var name='count' -->)</a></li>
<!-- /tmpl_loop -->
</ul></li>
<!-- /tmpl_loop -->
</ul>
<!-- /tmpl_if name='datecloud' -->

<!-- tmpl_if name='visual_tagcloud' -->
<h2>Tag Cloud</h2>
<!-- tmpl_var name='visual_tagcloud' -->
<!-- /tmpl_if -->
<!-- tmpl_if name='tagcloud' -->
<h2>Tags</h2>
<ul>
<!-- tmpl_loop name='tagcloud' -->
 <li><a href="<!-- tmpl_var name='top' -->tags/<!-- tmpl_var name='tag' escape='html' -->"><!-- tmpl_var name='tag' escape='html' --> (<!-- tmpl_var name='count' -->)</a></li>
<!-- /tmpl_loop -->
</ul>
<!-- /tmpl_if -->
