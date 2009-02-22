
			<ul>

                          <!-- tmpl_if name='datecloud' -->
			  <li id="archives">
                            <h3>Archive</h3>
                            <ul>
                              <!-- tmpl_loop name='datecloud' -->
                              <li><!-- tmpl_var name='year' -->
                                <ul>
                                  <!-- tmpl_loop name='months' -->
                                  <li><a href="<!-- tmpl_var name='top' -->archive/<!-- tmpl_var name='year' -->/<!-- tmpl_var name='month' -->/"><!-- tmpl_var name='month_name' --> (<!-- tmpl_var name='count' -->)</a></li>
                                  <!-- /tmpl_loop -->
                              </ul></li>
                              <!-- /tmpl_loop -->
                            </ul>
			  </li>
                          <!-- /tmpl_if name='datecloud' -->


                          <!-- tmpl_if name='tagcloud' -->
                          <li id="categories"><h3>Tags</h3>
                            <ul>
                              <!-- tmpl_loop name='tagcloud' -->
                              <li><a href="<!-- tmpl_var name='top' -->tags/<!-- tmpl_var name='tag' escape='html' -->"><!-- tmpl_var name='tag' escape='html' --> (<!-- tmpl_var name='count' -->)</a></li>
                              <!-- /tmpl_loop -->
                            </ul>
                          </li>
                          <!-- /tmpl_if -->

                          <li id="rss-links"><h3>RSS Feed</h3>

                            <ul>
                              <li><a href="index.rss"><img src="<!-- tmpl_var name='top' -->xml.gif" alt="RSS feed" width="36" height="14" /></a>
                              </li>
                            </ul>

                          </li>
                        </ul>

