#!/usr/bin/env python3
import argparse
import json
import re
import sys
from pathlib import Path


IMAGE_PATTERN = r"ghcr\.io/jiwon-projects/aws-infra-automation@sha256:[0-9a-f]{64}"


def main() -> int:
    parser = argparse.ArgumentParser(description="배포 기록에서 이미지 주소를 읽습니다.")
    parser.add_argument("record", type=Path, help="verified-release.json 파일 경로")
    args = parser.parse_args()

    try:
        record = json.loads(args.record.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as error:
        print(f"배포 기록을 읽을 수 없습니다: {error}", file=sys.stderr)
        return 1

    if not isinstance(record, dict):
        print("배포 기록은 JSON 객체여야 합니다.", file=sys.stderr)
        return 1

    image = record.get("image")
    if not isinstance(image, str) or not re.fullmatch(IMAGE_PATTERN, image):
        print("image에 프로젝트의 GHCR 주소와 SHA-256 Digest가 필요합니다.", file=sys.stderr)
        return 1

    source_commit = record.get("source_commit")
    if not isinstance(source_commit, str) or not re.fullmatch(r"[0-9a-f]{40}", source_commit):
        print("source_commit에는 전체 Git 커밋 SHA가 필요합니다.", file=sys.stderr)
        return 1

    run_id = record.get("run_id")
    if not isinstance(run_id, str) or not re.fullmatch(r"[1-9][0-9]*", run_id):
        print("run_id에는 숫자로 된 GitHub Actions 실행 ID가 필요합니다.", file=sys.stderr)
        return 1

    if record.get("verified_platform") != "linux/amd64":
        print("verified_platform은 현재 워크플로의 linux/amd64와 일치해야 합니다.", file=sys.stderr)
        return 1

    print(image)
    return 0


if __name__ == "__main__":
    sys.exit(main())