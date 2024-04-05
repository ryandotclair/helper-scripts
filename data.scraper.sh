# For when you need to curl data off a site that requires paging (400 pages by default).

for (( i=1 ; ((i-400)) ; i=(($i+1)) ))
do
  echo '{"page":'$i
  curl X \ 
  -H 'blah'
  --data-raw '{"page":'$i',"blah":true}' >> my.file.json
  sleep 2
done;