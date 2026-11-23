# Day 18 — 검증된 이미지의 배포 기록 저장

## 변경 내용

- 이미지 게시 워크플로에서 배포 검증 6개를 통과한 뒤 `verified-release.json`을 생성한다.
- 파일에 이미지 주소와 Digest(`image`), 빌드에 사용한 커밋(`source_commit`), 실행 검증 환경(`verified_platform`), Actions 실행 ID(`run_id`)를 기록한다.
- 파일을 GitHub Actions 결과물로 30일간 보관한다. 파일이 생성되지 않으면 업로드 단계가 실패한다.

## 검증 현황

- 로컬에서 YAML 문법과 예시 값으로 JSON이 생성되는 것을 확인했다.
- 워크플로 변경을 [PR #16](https://github.com/jiwon-projects/aws-infra-automation/pull/16)으로 `main`에 병합했다.
- 게시 실행의 `Summary → Artifacts`에서 `verified-release.json`을 내려받고, `image`의 Digest가 같은 실행 요약의 Digest와 일치하는지 확인한다.

## 배운 점

- Digest와 소스 커밋을 함께 남기면 어떤 코드로 빌드한 이미지를 검증했는지 추적할 수 있다.
- 이미지는 AMD64와 ARM64용으로 게시하고, 파일에 기록하는 실행 검증 환경은 `linux/amd64`다.
