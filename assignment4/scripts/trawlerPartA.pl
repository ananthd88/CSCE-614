$topLevelOutputDir = "../output/";
$relativepath = $topLevelOutputDir . $ARGV[0] . "/";
@files = (  "output_2lev_1_512_9",
            "output_2lev_1_512_6",
            "output_2lev_8_512_9",
            "output_2lev_8_512_6");
@metrics = ("bpred_2lev.dir_hits",     # Exclusively reflects performance of the branch predictor.
            "bpred_2lev.misses",       # Exclusively reflects performance of the branch predictor.
            "bpred_2lev.used_predictions", # Always = No. of branch statements including statements like return, uncondtional branches, etc
            "bpred_2lev.bpred_dir_rate");     # Always = dir_hits + misses
%filehandles = ();
foreach my $metric (@metrics)
{
   open $filehandles{$metric}, ">>" . $topLevelOutputDir . $metric . ".csv" or die "File $metric could not be opened";
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
