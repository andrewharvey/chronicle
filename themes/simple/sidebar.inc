			<ul>
                          <!-- tmpl_if name='datecloud' -->
			  <li id="archives">
                            <h3>Archive</h3>
                            <ul>
                              <!-- tmpl_loop name='datecloud' -->
                              <li><a href="#" onclick="toggle_visibility('year_<!-- tmpl_var name='year' -->'); return false" title="Click to toggle entries from the year <!-- tmpl_var name='year' -->"><!-- tmpl_var name='year' --></a>
                                <ul <!-- tmpl_unless name='__first__' -->style="display: none;" <!-- /tmpl_unless --> id="year_<!-- tmpl_var name='year' -->">
                                  <!-- tmpl_loop name='months' -->
                                  <li><a href="<!-- tmpl_var name='top' -->archive/<!-- tmpl_var name='year' -->/<!-- tmpl_var name='month' -->/"><!-- tmpl_var name='month_name' --> (<!-- tmpl_var name='count' -->)</a></li>
                                  <!-- /tmpl_loop -->
                              </ul></li>
                              <!-- /tmpl_loop -->
                            </ul>
			  </li>
                          <!-- /tmpl_if name='datecloud' -->
                          <!-- tmpl_if name='tagcloud' -->
                          <li id="categories"><h3>Tag List</h3>
                          <p id="tags_toggle"><a href="#" onclick="showCloud(); return false">Show all</a></p>
                            <ul id="tags" style="display:none;">
                              <!-- tmpl_loop name='tagcloud' -->
                              <li><a href="<!-- tmpl_var name='top' -->tags/<!-- tmpl_var name='tag' escape='html' -->"><!-- tmpl_var name='tag' escape='html' --> (<!-- tmpl_var name='count' -->)</a></li>
                              <!-- /tmpl_loop -->
                            </ul>
                          </li>
                          <!-- /tmpl_if -->
                          <li id="rss-links"><h3>RSS Feed</h3>
                            <ul>
                              <li><a href="<!-- tmpl_var name='top' -->index.rss"><img src="<!-- tmpl_var name='top' -->xml.gif" alt="RSS feed" width="36" height="14" /></a>
                              </li>
                            </ul>
                          </li>
                        </ul>
