# Read version from pubspec
QUOKKA_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${QUOKKA_VERSION_REGEX}" pubspec.yaml) =~ ${QUOKKA_VERSION_REGEX} ]]
QUOKKA_VERSION="${BASH_REMATCH[1]}"
# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $QUOKKA_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Quokka $RPM_VERSION"
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
# Copy files
cp linux/rpm/linwood-quokka.spec build/SPECS/linwood-quokka.spec
cp -r build/linux/x64/release/bundle build/SOURCES/linwood-quokka-$RPM_VERSION
chmod 755 build/SOURCES/linwood-quokka-$RPM_VERSION/quokka
mv build/SOURCES/linwood-quokka-$RPM_VERSION/quokka build/SOURCES/linwood-quokka-$RPM_VERSION/linwood-quokka
cp linux/rpm/linwood-quokka.desktop build/SOURCES/linwood-quokka-$RPM_VERSION/linwood-quokka.desktop
# Change second line of spec file Version: to match version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-quokka.spec
# Create tar
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-quokka-$RPM_VERSION/lib
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
tar --create --file linwood-quokka-$RPM_VERSION.tar.gz linwood-quokka-$RPM_VERSION
cd ../../
# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-quokka.spec --define "_topdir $(pwd)/build"
# Copy RPM to build folder
cp build/RPMS/x86_64/linwood-quokka-*.rpm build/linwood-quokka-linux-x86_64.rpm