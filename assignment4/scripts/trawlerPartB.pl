$topLevelOutputDir = "../output/";
$relativepath = $topLevelOutputDir . $ARGV[0] . "/";
@files = (  "output_2lev_1_4096_9",
            "output_tour_4096_12_1024_10");
@metrics = ("dir_hits",     # Exclusively reflects performance of the branch predictor.
            "misses",       # Exclusively reflects performance of the branch predictor.
            "used_predictions", # Always = dir_hits + misses
            "bpred_dir_rate");     
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
