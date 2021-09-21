control_c() {
     kill $(lsof -ti tcp:8080)
     kill $PID
     exit
}

trap control_c SIGINT

kill $(lsof -ti tcp:8080)
python3 -m http.server 8080 &
open http://localhost:8080
fswatch -v ./presentation.adoc | while IFS= read -r line; do
     npx asciidoctor-revealjs presentation.adoc
     mv presentation.html index.html
     PID=$!

done
