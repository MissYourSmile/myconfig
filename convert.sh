mkdir -p png_2560x1440
for f in $(ls *.png)
do
    echo "convert ${f} to png_2560x1440/${f%.*}.png"
    magick \( -size 2560x1440 canvas:"#1e1e2e" \) \
           \( "${f}" -trim +repage -resize 1024x576 \)\
           -gravity southeast -geometry +0+80 -composite \
           png_2560x1440/${f%.*}.png
done
