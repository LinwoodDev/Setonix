# Read version from pubspec
SETONIX_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${SETONIX_VERSION_REGEX}" pubspec.yaml) =~ ${SETONIX_VERSION_REGEX} ]]
SETONIX_VERSION="${BASH_REMATCH[1]}"
# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $SETONIX_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Setonix $RPM_VERSION"
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
# Copy files
cp linux/rpm/linwood-setonix.spec build/SPECS/linwood-setonix.spec
cp -r build/linux/x64/release/bundle build/SOURCES/linwood-setonix-$RPM_VERSION
chmod 755 build/SOURCES/linwood-setonix-$RPM_VERSION/setonix
mv build/SOURCES/linwood-setonix-$RPM_VERSION/setonix build/SOURCES/linwood-setonix-$RPM_VERSION/linwood-setonix
cp linux/rpm/linwood-setonix.desktop build/SOURCES/linwood-setonix-$RPM_VERSION/linwood-setonix.desktop
# Change second line of spec file Version: to match version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-setonix.spec
# Create tar
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-setonix-$RPM_VERSION/lib
for file in *.so; do
  PATCHELF_OUTPUT=$(patchelf --print-rpath $file)
  echo "Checking $file: $PATCHELF_OUTPUT"
  # Skip file if PATCHELF_OUTPUT does not contain CURRENT_DIR
  if [[ ! $PATCHELF_OUTPUT =~ $CURRENT_DIR ]]; then
    echo "Skipping $file"
    continue
  fi
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' $file
done
cd ../../
tar --create --file linwood-setonix-$RPM_VERSION.tar.gz linwood-setonix-$RPM_VERSION
cd ../../
# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-setonix.spec --define "_topdir $(pwd)/build"
# Copy RPM to build folder
cp build/RPMS/x86_64/linwood-setonix-*.rpm build/linwood-setonix-linux-x86_64.rpm