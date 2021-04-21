# use Env qw(df);

# print "$ARGV[0]\n";
# $file=$ARGV[0];

# foreach(`sort $file|uniq`) {
while(<>) {
    foreach(split /\s/, $_) {
        $words{$_}++;
    }
    foreach(split /-/, $_) {
        $words{$_}++;
    }
}
foreach(sort keys %words) {
    print "$_\n";
}
