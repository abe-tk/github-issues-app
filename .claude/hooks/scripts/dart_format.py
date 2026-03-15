#!/usr/bin/env python3
"""
PostToolUse フック: Write / Edit ツール実行後に .dart ファイルを自動フォーマットする
"""

import json
import subprocess
import sys


def main() -> None:
    data = json.loads(sys.stdin.read())

    tool_name = data.get("tool_name", "")
    tool_input = data.get("tool_input", {})

    # Write / Edit ツール以外はスキップ
    if tool_name not in ("Write", "Edit"):
        return

    file_path = tool_input.get("file_path", "")

    # .dart ファイル以外はスキップ
    if not file_path.endswith(".dart"):
        return

    # 生成済みファイル（.g.dart / .freezed.dart）はスキップ
    if file_path.endswith(".g.dart") or file_path.endswith(".freezed.dart"):
        return

    result = subprocess.run(
        ["dart", "format", file_path],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        # フォーマット失敗時は stderr に出力（Claude に通知される）
        print(f"dart format 失敗: {result.stderr}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
