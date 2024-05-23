Name:           linwood-quokka
Version:        1.0.0
Release:        1%{?dist}
Summary:        Play games everywhere you like
BuildArch:      x86_64
URL:            https://github.com/LinwoodDev/Quokka
License:        AGPLv3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
Coming soon...

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{name}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/pixmaps
cp %{name} $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R lib $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R data $RPM_BUILD_ROOT/%{_datadir}/%{name}
ln -s %{_datadir}/%{name}/%{name} $RPM_BUILD_ROOT/%{_bindir}/%{name}
desktop-file-install %{name}.desktop

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
/usr/share/applications/
