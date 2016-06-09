# Picture_Search_Engine
There are two types of engine, one is based on color descriptor, another is based on descriptor of point of interest(here we choose algorithm sift(scale-invariant feature transform)), they have written by Perl with CGI script(see here: https://en.wikipedia.org/wiki/Common_Gateway_Interface), so make sure that your browser supports CGI before using these files. In my search engine, I have already trained it with more than 9000 pictures, so the final result of these engines is selected from this picture library.
## Using instruction
* If you want to use 'color based'(feature based) engine, just go to folder color(sift), open picture_research.html(sift_research.html) in your browser, fill in a picture's link on internet or a picture's local path, click OK to see the result. 
* If you want to combine two engines' result, just use synthese_recherche.html, but now, you have to put all the files in one folder.

## Tips
* When you use sift engine, it will take about 5 to 15 seconds before showing the result, if the picture is big, maybe even longer than that, because sift algorithme calculate the picture's feature vector everytime.
* The executable file colorDescriptor in folder sift is provided by Koen van de Sande(page: http://koen.me/research/colordescriptors/) please follow the rules of copyright in his page.
