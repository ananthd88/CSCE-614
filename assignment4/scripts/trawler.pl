$relativepath = "../output/" . $ARGV[0] . "/";
@files = (  "output_1_512_9",
            "output_1_512_6",
            "output_8_512_9",
            "output_8_512_6");
@metrics = ("bpred_2lev.addr_hits", 
            "bpred_2lev.dir_hits", 
            "bpred_2lev.misses", 
            "bpred_2lev.lookups", 
            "bpred_2lev.updates");
%filehandles = ();
foreach my $metric (@metrics)
{
   open $filehandles{$metric}, ">>" . $metric . ".csv" or die "File $metric could not be opened";
}

foreach my $file (@files)
{
   open $filehandle, "<" . $relativepath . $file or die "File $file could not be opened";
   
   while(<$filehandle>)
   {
      foreach my $metric (@metrics)
      {
         $pattern = $metric . "\\s*" . "([\\.0-9]+)" . " #";
         $_ =~ m/$pattern/;
         if($_ =~ /$pattern/)
         {
            $temp = $filehandles{$metric};
            print $temp $file . ", " . $1 . "\n";
         }
      }
   }
}
print "Done\n";
