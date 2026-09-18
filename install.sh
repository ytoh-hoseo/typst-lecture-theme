#!/usr/bin/env bash
# lecture-theme를 typst 로컬 패키지(@local/lecture-theme:버전)로 등록한다.
# typst는 <패키지 루트>/local/<이름>/<버전>/ 폴더를 그 이름으로 인식하는데,
# 이 저장소를 복사하는 대신 그 위치에 심볼릭 링크를 걸어 수정 사항이 바로 반영되게 한다.
# 패키지 루트는 TYPST_PACKAGE_PATH 환경변수(conda tools 환경 등)가 있으면 그것을,
# 없으면 OS별 기본 위치를 사용한다 — typst가 실제로 참조하는 위치와 동일한 규칙이다.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$REPO_DIR/typst.toml"

NAME=$(sed -nE 's/^name *= *"(.*)"/\1/p' "$MANIFEST" | head -1)
VERSION=$(sed -nE 's/^version *= *"(.*)"/\1/p' "$MANIFEST" | head -1)

if [ -z "$NAME" ] || [ -z "$VERSION" ]; then
  echo "typst.toml에서 name/version을 읽지 못했습니다." >&2
  exit 1
fi

if [ -n "${TYPST_PACKAGE_PATH:-}" ]; then
  PKG_ROOT="$TYPST_PACKAGE_PATH"
elif [ "$(uname)" = "Darwin" ]; then
  PKG_ROOT="$HOME/Library/Application Support/typst/packages"
else
  PKG_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages"
fi

TARGET_DIR="$PKG_ROOT/local/$NAME"
mkdir -p "$TARGET_DIR"
ln -sfn "$REPO_DIR" "$TARGET_DIR/$VERSION"

echo "설치 완료: @local/$NAME:$VERSION"
echo "  -> $REPO_DIR"
echo "  ($TARGET_DIR/$VERSION)"
