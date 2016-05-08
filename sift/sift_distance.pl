#!/usr/bin/perl
use CGI;
use URI::Escape;
use FindBin;

      my $paramStr = $ENV{QUERY_STRING};
      my @FORM = split('=',$paramStr);
      my $adresse = uri_unescape($FORM[1]);
      `/usr/local/bin/wget $adresse`;
      my $image = `basename $adresse`;
# # #      my ($image) = $_;
      #`./colorDescriptor --descriptor sift $image --output sample.sift`;
       `$FindBin::Bin/pretraiter.sh $image`;
      # # `R --slave --no-save --no-restore --no-environ --args centers256.txt 256 trav.sift res1nn.txt < 1nn.R`;
       my $str = `cat first_analyse`;
#       print "$str";
      # print "$str";

      my @colormap=split(' ',$str);
      my %score = ();
      open(F,"./mapping.sift") || die "Erreur d'ouverture du fichier mapping.sift \n";
      my $i = 0;
      while (my $ligne = <F>){
        my @score_line = split(' ',$ligne);
        my $chiffre = 0;
        for(my $j = 0; $j < 256; $j++){
          $chiffre = $chiffre + ($colormap[$j]-$score_line[$j])*($colormap[$j]-$score_line[$j]);
        }
#        print "$chiffre \n";
        $score{$i} = $chiffre;
        $i++;
      }
      close(F);
    my @topk;
    my $counter = 0;
    foreach my $key (sort {$score{$a} <=> $score{$b}} keys %score) {
    my $value = $score{$key};
#    print "value: $value key: $key\n";

    $topk[$counter] = $key;
      $counter++;
    if($counter == 10){#nombre de resultat
      last;
    }

 }
#      printf "$score{0} $score{1}\n";

      open(SF,"./urls.txt") || die "Erreur d'ouverture du fichier urls.txt \n";
      my @lien;
      my $k = 0;
      while (my $line = <SF>){
        $lien[$k] = $line;
        $k++
      }

      print "Content-type:text/html\r\n\r\n";
      print '<html>';
      print '<head>';
      print '<title>Resultat</title>';
      print '</head>';
      print '<body>';

      print '<h1>Image Originale</h1>';
      # print "<h1>$FORM[1]</h1>";
      # print "<h1>$image</h1>";
#      print "<h1>output $output</h1>";
#      print "<h1>findbin $FindBin::Bin</h1>";



    #   pour afficher toute conficuration de systeme
    #   while (my ($key,$value) = each %ENV) {
    #       print "<h1>$key=$value</h1>\n";
    # }

      print "<table><tr><td>";
      print "<h2>Image Origine</h2>";
      print "<IMG SRC=$adresse >\n";
      print "</td></tr></table>";
    #  print "<h2>form $adresse</h2>";
      # print "<h2>$image</h2>";
      # print "<h2>$paramStr</h2>";
      # print "<h2>url $url</h2>";
      print '<h2>Resultat</h2>';
      print "<table><tr>\n";
      for(my $cpt = 0; $cpt < 10; $cpt++){
        print "<td>\n";
        print "<IMG SRC=$lien[$topk[$cpt]]><p>\n";
        print "</td>\n";
      }
      print "</tr></table>\n";
      print '</body>';
      print '</html>';


    #  print "$colormap[0]\n";
    #  my $temp = scalar($colormap);
    #  print "$temp\n";
