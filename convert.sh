for f in $(ls *.png)
do
    echo "convert ${f} to jpg/${f%.*}.jpg"
    # ffmpeg -i ${f} -vf "format=rgb24, scale=iw:ih, pad=iw:ih:(ow-iw)/2:(oh-ih)/2:white" -q:v 2 jpg/${f%.*}.jpg
    magick ${f} -background black -flatten jpg/${f%.*}.jpg
done
