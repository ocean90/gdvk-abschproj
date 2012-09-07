find . -regex ".*\.\(svg\)" | while read FILE; do
rsvg-convert $FILE > $FILE.png
done;
