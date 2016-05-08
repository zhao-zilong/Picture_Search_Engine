#!/usr/bin/perl -w
#use diagnostics;
#use strict;
#use Cwd 'abs_path';
use CGI;
use URI::Escape;
use FindBin;
       #
       my $paramStr = $ENV{QUERY_STRING};
       my @FORM = split('=',$paramStr);
       my $image = uri_unescape($FORM[1]);

#       my $image = 'http://echopaw.fr/wp-content/uploads/2015/09/animals-41.jpg';
#       #print "image: $image\n";
#       #my ($image) = $_;
       #obtenir histogramm de image
       #`/Library/WebServer/CGI-Executables/read_image http://www.allkpop.com/upload/2015/07/content/Shin-Se-Kyung_1437525895_shin2.jpg`;
       #$output = system("/Library/WebServer/CGI-Executables/read_image","http://www.allkpop.com/upload/2015/07/content/Shin-Se-Kyung_1437525895_shin2.jpg");
#       my $output = system("$FindBin::Bin/read_image", '/Users/zhaozilong/Documents/s8/ri/tp_media/img/winter.jpg');

       `$FindBin::Bin/read_image $image`;
       #$output =`$FindBin::Bin/read_image http://www.allkpop.com/upload/2015/07/content/Shin-Se-Kyung_1437525895_shin2.jpg`;

       open(F,"./histogram.txt");
       my $str = <F>;
       close(F);
       my @colormap=split(' ',$str);
       my %score = ();
       open(F,"./scores.txt") || die "Erreur d'ouverture du fichier \n";
       my $i = 0;
      while (my $ligne = <F>){
         my @score_line = split(' ',$ligne);
         my $chiffre = 0;

        for(my $j = 0; $j < 64; $j++){
         my $temp = $colormap[$j] - $score_line[$j];
          $chiffre = $chiffre + $temp*$temp;
        }
#        print "$chiffre \n";
        $score{$i} = $chiffre;
        $i++;
      }



       close(F);
    my $topk;
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


      open(SF,"./urls.txt") || die "Erreur d'ouverture du fichier \n";
      my $lien;
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
#      print "<h1>$str</h1>";
#      print "<h1>output $output</h1>";
#      print "<h1>findbin $FindBin::Bin</h1>";



    #   pour afficher toute conficuration de systeme
    #   while (my ($key,$value) = each %ENV) {
    #       print "<h1>$key=$value</h1>\n";
    # }

      print "<table><tr><td>";
      print "<h2>Image Origine</h2>";
      print "<IMG SRC=$image >\n";
      print "</td></tr></table>";
      # print "<h2>$str</h2>";
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

#      print "$colormap[0]\n";
#      my $temp = scalar($colormap);
#      print "$temp\n";
