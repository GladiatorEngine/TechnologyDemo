rm -rf .rbuild
mkdir -p .rbuild/resources
shopt -s nullglob
for f in TechnologyDemo/Resources/Source/textures/**.png; do
    gladiator-tools asset-builder texture build -p "$f" -o ".rbuild/resources/texture_$(basename "${f%.*}").gea"
done
for f in TechnologyDemo/Resources/Source/models/**.json; do
    gladiator-tools asset-builder model build -v "$f" -o ".rbuild/resources/model_$(basename "${f%.*}").gea"
done
gladiator-tools asset-builder pack build .rbuild/resources/*.gea -o .rbuild/pack.gea
cp .rbuild/pack.gea TechnologyDemo/Resources/pack.gea
rm -rf .rbuild

