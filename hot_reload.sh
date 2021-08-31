kill $(lsof -ti tcp:8080)
python -m http.server 8080 &
open http://localhost:8080
fswatch -v ./**/*.adoc index.adoc docinfo/local/* | while IFS= read -r line;
do
     asciidoctor -r asciidoctor-bibtex -a stem -a docinfodir="./configuration/local" index.adoc
done
