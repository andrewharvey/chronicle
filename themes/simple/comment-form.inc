<p>&nbsp;</p>
<!-- tmpl_if name='comments_enabled' -->
<div id="output">
<h3>Add A Comment</h3>
<blockquote>
<form action="/cgi-bin/comments.cgi" method="post">
<input type="hidden" name="id" value="<!-- tmpl_var name='link' escape='html' -->">
<input type="hidden" name="captcha" value="">
<table>
<tr><td><b>Name</b>:</td>
    <td><input type="text" size="55" name="name"></td></tr>
<tr><td><b>Email</b>:</td>
    <td><input type="text" size="55" name="mail"></td></tr>
<tr><td><b>Website</b>:</td>
    <td><input type="text" size="55" name="link"></td></tr>
<tr><td colspan="2"><b>Your Comment</b><br />
<textarea name="body" rows="10" cols="60">
</textarea></td></tr>
<tr><td></td><td align="right"><div id="progress" style="display:none;"><img src="progress.gif" alt="" width="36" height="36"></div><input type="submit" name="submit" value="Post Comment" onClick="submitComment(); return false;"></td></tr>
</table>
</form>
<p>Your submission will be ignored if the name, email, or comment field is left blank.</p>
<p>Your email address will <b>never</b> be displayed, but your homepage will be.</p>
</blockquote>
</div>
<!-- /tmpl_if -->
