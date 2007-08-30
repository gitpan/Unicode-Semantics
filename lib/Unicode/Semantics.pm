package Unicode::Semantics;
use base 'Exporter';
$VERSION = "1.00";
@EXPORT = qw(us);

sub us ($) {
        utf8::upgrade($_[0]);
            return $_[0];
}

1;

__END__

=head1 NAME

Unicode::Semantics - Work around *the* Perl 5 Unicode bug

=head1 SYNOPSIS

    $foo;      # could be anything
    us($foo):  # force Unicode semantics

or:

    us($foo) =~ s/\W/_/g;  # Upgrade and use immediately

=head1 DESCRIPTION

Perl uses Unicode semantics when the I<internal> encoding for a string is
UTF-8, but it uses I<ASCII> semantics when the internal encoding is ISO-8859-1.
This means that the non-ASCII part of the character set is ignored when for
the following operations:

    * uc, lc, ucfirst, lcfirst, \U, \L, \u, \l
    * \d, \s, \w, \D, \S, \W
    * /.../i, (?i:...)
    * /[[:posix:]]/

Because you shouldn't (and often don't) know what the internal encoding will
be, it's hard to predict whether these operations will actually do what you
want. Unicode::Semantics::us() gives you predictable results.

This module exports C<us> that upgrades your string to UTF-8 internally and
returns the string.

You can also use C<utf8::upgrade>, which does exactly the same thing, except
that it does not return the string. This module was released because it's
less typing in a large program :)

=head1 BINARY STRINGS

Obviously, these broken text operations are no problem when you're dealing
with bytes instead of characters. Don't upgrade your binary strings!

=head1 AUTHOR

Juerd Waalboer <#####@juerd.nl>

=head1 SEE ALSO

perlunitut, perlunifaq
