no warnings;
use Unicode::Semantics;

print "1..3\n";
sub is {
    my ($foo, $bar, $baz) = @_;
    print "not " if $foo ne $bar;
    print "ok ", ++$i, " # $baz\n";
    if ($foo ne $bar) {
        warn "Expected [$bar], got [$foo]\n";
    }
}

use charnames qw(:full);
binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";
my $foo = "\xf6";
is(uc($foo), "\N{LATIN SMALL LETTER O WITH DIAERESIS}", "Doesn't work without upgrading (not OK, but this test will fail once this module is no longer needed");
is(uc(us($foo)), "\N{LATIN CAPITAL LETTER O WITH DIAERESIS}", "Yay, works now");
is(uc($foo), "\N{LATIN CAPITAL LETTER O WITH DIAERESIS}", "Stays upgraded");

