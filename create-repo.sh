#!/usr/bin/env bash
set -e

REPO="airesumewriter/copilot-crm-builder"
DIR="$(pwd)"

gh auth status >/dev/null 2>&1 || { echo "Login with 'gh auth login'"; exit 1; }

if ! gh repo view "$REPO" >/dev/null 2>&1; then
  gh repo create "$REPO" --public --confirm
else
  echo "Repo $REPO already exists."
fi

cd "$DIR"
git init
git add .
git commit -m "Initial commit: complete Copilot Builder system"
git branch -M main

if git remote | grep origin >/dev/null 2>&1; then
  git remote set-url origin "git@github.com:$REPO.git"
else
  git remote add origin "git@github.com:$REPO.git"
fi

git push -u origin main

echo "✅ Pushed to https://github.com/$REPO"

