find . -name '*.gyb' |
while read file; do
    gyb --line-directive '' -o "ViperDemo/Configs/${file%.gyb}" "$file";
done