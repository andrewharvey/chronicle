
          <!-- tmpl_if name='calendar' -->
          <!-- tmpl_var name='calendar_month' -->
          <!-- /tmpl_if name='calendar' -->
          <!-- tmpl_if name='datecloud' -->
          <fieldset><legend>Archive</legend>
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
          </fieldset>
          <!-- /tmpl_if name='datecloud' -->
          <!-- tmpl_if name='tagcloud' -->
          <fieldset>
            <legend>Tags</legend>
            <!-- tmpl_loop name='tagcloud' -->
            <span style="font-size: <!-- tmpl_var name='size' -->px"><a href="<!-- tmpl_var name='top' -->tags/<!-- tmpl_var name='tag'  escape='html' -->"><!-- tmpl_var name='tag' escape='html' --></a><!-- tmpl_if name="__last__" -->.<!-- tmpl_else -->, <!-- /tmpl_if --></span>
            <!-- /tmpl_loop -->
          </fieldset>
          <!-- /tmpl_if -->
