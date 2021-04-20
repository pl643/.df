foreach(`sort /tmp/.pane|uniq`) {
    next if /^\s*$/;
    chomp;
    push @lines,$_;
    foreach(split /\s/, $_) {
        next if /^\s*$/;
        s/\s*$//;
        $words{$_}++;
    }
    foreach(split /-/, $_) {
        s/\s*$//;
        $words{$_}++;
    }
}
foreach(sort keys %words) {
    print "$_\n";
}
foreach(@lines) {
    if ( $words{"$lines"} < 1) {
        print("lines: $_\n")
    } 
}
