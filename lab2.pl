use v6;
my $filename = "access.log";
my $res = {};
my $iter = 0;

if (my $fh = open $filename, :r) {
    for $fh.lines -> $line {
		my $regRes = ($line ~~ /(^\d ** 0^..^4\.\d  ** 0^..^4\.\d  ** 0^..^4\.\d  ** 0^..^4) \s\- \s\-/)[0];
		if !$regRes {next;}
		if $res{$regRes} {
		$res{$regRes} += 1;
		} else {
		$res{$regRes} = 1
		}
	}
}

if keys($res).elems != 0 {
	for $res.keys.sort: { $res{$^b} <=> $res{$^a} } -> $key {
	$iter += 1;
	say "TOP $iter is $key ip, with $res{$key} request.";
	last if ($iter == 10);;
	}
} else {
	die "No one line was found";
}