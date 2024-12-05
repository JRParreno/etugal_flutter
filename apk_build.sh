fvm flutter clean 
fvm flutter pub get 
fvm flutter pub run build_runner build --delete-conflicting-outputs 
fvm flutter build apk --release --no-tree-shake-icons \
  --dart-define=CLIENT_ID=CfHxMuO8FVQGYFw1r6CDQqbYofXZ3BGTCj0cm0Tb \
  --dart-define=CLIENT_SECRET=3OR52hKl7g2BJuxzKeHyrIyBDE84bpUaN7crpCc9RLQWKJCLektONvMXsBOICtxZJ1libxIGu0mqNc1hxEYcJJdlUgavWpJmT62igqCRLwVFjbAD8fL6mnjDVm4m4Hlj \
  --dart-define=API_URL=https://etugal-core.onrender.com \
  --dart-define=SERVER_HOST=etugal-core.onrender.com