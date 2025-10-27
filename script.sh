#!/usr/bin/env bash
set -euo pipefail

ROOT="my-pipeline-project"

# Directories
mkdir -p "$ROOT"/app/src \
         "$ROOT"/app/tests \
         "$ROOT"/.github/workflows \
         "$ROOT"/docs/screenshots \
         "$ROOT"/scripts

# Files
touch "$ROOT"/app/Dockerfile
touch "$ROOT"/.github/workflows/ci-cd.yml
touch "$ROOT"/docs/architecture.md
touch "$ROOT"/README.md
touch "$ROOT"/scripts/deploy.sh
chmod +x "$ROOT"/scripts/deploy.sh

# Optional: starter contents
cat > "$ROOT"/README.md <<'EOF'
# my-pipeline-project

Project scaffold initialized.
EOF

cat > "$ROOT"/.github/workflows/ci-cd.yml <<'EOF'
name: CI/CD
on:
  push:
    branches: [ "main" ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Print working dir
        run: pwd
EOF

cat > "$ROOT"/scripts/deploy.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo "Deploy script placeholder"
EOF

echo "✅ Project scaffold created successfully at $ROOT"
