# Read version from pubspec
QECK_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${QECK_VERSION_REGEX}" pubspec.yaml) =~ ${QECK_VERSION_REGEX} ]]
QECK_VERSION="${BASH_REMATCH[1]}"
# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $QECK_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Qeck $RPM_VERSION"
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
# Copy files
cp linux/rpm/linwood-qeck.spec build/SPECS/linwood-qeck.spec
cp -r build/linux/x64/release/bundle build/SOURCES/linwood-qeck-$RPM_VERSION
chmod 755 build/SOURCES/linwood-qeck-$RPM_VERSION/qeck
mv build/SOURCES/linwood-qeck-$RPM_VERSION/qeck build/SOURCES/linwood-qeck-$RPM_VERSION/linwood-qeck
cp linux/rpm/linwood-qeck.desktop build/SOURCES/linwood-qeck-$RPM_VERSION/linwood-qeck.desktop
# Change second line of spec file Version: to match version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-qeck.spec
# Create tar
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-qeck-$RPM_VERSION/lib
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
tar --create --file linwood-qeck-$RPM_VERSION.tar.gz linwood-qeck-$RPM_VERSION
cd ../../
# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-qeck.spec --define "_topdir $(pwd)/build"
# Copy RPM to build folder
cp build/RPMS/x86_64/linwood-qeck-*.rpm build/linwood-qeck-linux.rpm
