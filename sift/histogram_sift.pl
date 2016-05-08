sub traiter($){
   my ($Filename)=@_;
   open(F,"$Filename") || die "Erreur d'ouverture du fichier $Filename \n";
   my @histogram = ();
   while(my $line = <F>){
     $histogram[$line]++;
   }
  #  my $name = `basename $Filename`;
  #  open(NF,">./histogram/$name");
  #  for(my $i = 1; $i <= 256; $i++){
  #    if(exists ($histogram[$i])){
  #    print NF "$histogram[$i] ";
  #   }
  #    else{
  #      print NF "0 ";
  #      }
  #   }
  #   print NF "\n";


    my $resultat;
    my $count = 0;
    for(my $i = 1; $i <= 256; $i++){
      if(exists ($histogram[$i])){
      $count = $count + $histogram[$i];
     }
    }
    my $temp;
    for(my $i = 1; $i <= 256; $i++){
      if(exists ($histogram[$i])){
      $temp = $histogram[$i]/$count;
      $temp = sprintf "%0.6f",$temp;
      $resultat = $resultat.$temp." ";
     }
      else{
        $resultat = $resultat."0.000000 ";
        }
     }
    $resultat = $resultat."\n";
    print "$resultat";
    return $resultat;
}
traiter($ARGV[0]);
