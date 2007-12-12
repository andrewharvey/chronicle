#!/usr/bin/perl -w
#
#  This is a simple script which is designed to accept POST request,
# of comments to a series of text files.
#
#  This code is very simple and should be easy to extend with anti-spam
# at a later point.
#
# Steve
# --
#



use strict;
use warnings;
use CGI;

#
#  The directory to store comments in
#
my $COMMENT = $ENV{'DOCUMENT_ROOT'} . "../comments/";


#
#  Get the parameters from the request.
#
my $cgi  = new CGI();
my $name = $cgi->param('name') || undef;
my $mail = $cgi->param('mail') || undef;
my $body = $cgi->param('body') || undef;
my $id   = $cgi->param('id')   || undef;


#
#  If any are missing just redirect back to the blog homepage.
#
if ( !defined( $name )  || !length( $name ) ||
     !defined( $mail )  || !length( $mail ) ||
     !defined( $body )  || !length( $body ) ||
     !defined( $id )    || !length( $id ) )
{
    print "Location: http://" . $ENV{'HTTP_HOST'} . "/\n\n";
    exit;
}


#
#  Otherwise save them away.
#
#
#  ID.
#
if ( $id =~ /^(.*)[\/\\](.*)$/ ){
    $id=$2;
}


#
# get the current time
#
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
  localtime(time);

#
#  Open the file.
#
my $file = $COMMENT . "/" . $id . "." . "$mday-$mon-$year-$hour-$min-$sec";
open( FILE, ">", $file );
print FILE "Name: $name\n";
print FILE "Mail: $mail\n";
print FILE "User-Agent: $ENV{'HTTP_USER_AGENT'}\n";
print FILE "IP-Address: $ENV{'REMOTE_ADDR'}\n";
print FILE  "\n";
print FILE $body;
close( FILE );

#
#  Now show the user the thanks message..
#
print "Content-type: text/html\n\n";
print <<EOF;
<html>
 <head>
  <title>Thanks For Your Comment</title>
 </head>
 <body>
  <h2>Thanks!</h2>
  <p>Your comment will be included the next time this blog is rebuilt.</p>
  <p><a href="http://$ENV{'HTTP_HOST'}/">Return to blog</a>.</p>
 </body>
</html>
EOF

