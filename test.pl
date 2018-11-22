# https://perlmaven.com/

# Comme en JS.
use strict;
use warnings;

# "Variable globales" pas vraiment utile. --------------------------------------
$_ = 'Toto';
print($_ . "\n");

# Scalar.
my $scalar = 'Baz';
print($scalar . "\n");

# Tableau. ---------------------------------------------------------------------
# my $array = [ 'Bill', 'Ben, 'Mary' ];
# my @array = qw(Foo Bar Baz); # Pas top
my @array = ('Foo', 'Bar', 'Baz');
if (grep $_ eq $scalar, @array) {
  print(@array . "\n");
}

# Hash. ------------------------------------------------------------------------
my %hash = (
  Man => 'Bill',
  Woman => 'Mary',
  Dog => 'Ben',
  tableau => [qw(
    !energy
    -energy-from-fat-
  )
  ],
);
print(%hash);
print("\n");
print($hash{Woman} . "\n");

# Variables d'environment. -----------------------------------------------------
print(%ENV{PATH});
print("\n");

# Utilisation d'un module (namespace). -----------------------------------------
use lib '/var/www/docker-apache-perl';
use TestModule;

print(TestModule->add(5, 10));
print("\n");

# Lecture de fichier. ----------------------------------------------------------
# my $data_root = 'openfoodfacts-server';
# my $www_root = $data_root . '/html';
# opendir DH2, "$data_root/lang" or die "Couldn't open $data_root/lang : $!";
# foreach my $langid (readdir(DH2)) {
#   next if $langid eq '.';
#   next if $langid eq '..';
#   next if ((length($langid) ne 2) and not ($langid eq 'other'));

#   if (-e "$www_root/images/lang/$langid") {
#     opendir DH, "$www_root/images/lang/$langid" or die "Couldn't open the current directory: $!";
#     foreach my $tagtype (readdir(DH)) {
#       next if $tagtype =~ /\./;
#     }
#     closedir(DH);
#   }
# }
# closedir(DH2);
# print("\n");

# my @ssl_subdomains = qw(
# ssl-api
# );
# if ('*' ~~ @ssl_subdomains) {
#   print('~~');
# }
# if (grep $_ eq '*', @ssl_subdomains) {
#   print('grep');
# }

# http://perldoc.perl.org/perldiag.html#Possible-attempt-to-put-comments-in-qw()-list
# my %nutriments_tables = (
#   us_before_2017 => [qw(!energy, -energy-from-fat-)]
# );
# my %nutriments_tables = (
#   us_before_2017 => [('!energy', '-energy-from-fat-')]
# );
# print($nutriments_tables{'us_before_2017'}[1]);
# print("\n");
