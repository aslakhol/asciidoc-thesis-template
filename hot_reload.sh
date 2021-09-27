control_c() {
     kill $(lsof -ti tcp:8080)
     kill $PID
     exit
}

trap control_c SIGINT

kill $(lsof -ti tcp:8080)
python3 -m http.server 8080 &
open http://localhost:8080
fswatch -v ./**/*.adoc index.adoc configuration/* | while IFS= read -r line; do
     asciidoctor -r asciidoctor-bibtex -a stem -a docinfodir="./configuration/local" index.adoc
     PID=$!

done
