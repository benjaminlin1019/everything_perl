#!/usr/bin/perl
# Test random things here
# use Data::Dumper;

# open FILE, '/usr/share/dict/words';
# my %char_cnt;

# while (my $word = <FILE>) {
#     my @chars = split('', $word);
#     foreach(@chars) {
#         $_ = lc $_;
#         if(exists $char_cnt{$_})
#         {
#             $char_cnt{$_} += 1;
#         }
#         else
#         {
#             $char_cnt{$_} = 1;
#         }
#     }
# }
# print(Dumper(%char_cnt));
# my @top_5_chars = sort {$char_cnt{$b} <=> $char_cnt{$a}} keys %char_cnt;
# $patt_chars = join('', @top_5_chars[0..5]);

# $pattern = "[$patt_chars]";

$a = 5;
$b = 20;
if($a < $b) {
    print("$a < $b\n");
}
else{
    print("$a > $b\n");
}

