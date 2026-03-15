#!/usr/bin/env python3
"""
Stop フック: Claude の応答が完了したタイミングで flutter analyze を実行する。
.dart ファイルの編集が1件以上あったセッションでのみ実行する。
"""

import json
import os
import subprocess
import sys


def session_has_dart_edits(transcript_path: str) -> bool:
    """会話ログに .dart ファイルへの Write / Edit が含まれるか確認する"""
    if not transcript_path or not os.path.exists(transcript_path):
        return False

    try:
        with open(transcript_path, encoding="utf-8") as f:
            content = f.read()
        return ".dart" in content and any(
            tool in content for tool in ('"Write"', '"Edit"')
        )
    except Exception:
        return False


def main() -> None:
    data = json.loads(sys.stdin.read())

    transcript_path = data.get("transcript_path", "")
    cwd = data.get("cwd", "")

    # .dart の編集がない場合はスキップ（不要な実行を避ける）
    if not session_has_dart_edits(transcript_path):
        return

    result = subprocess.run(
        ["flutter", "analyze", "--no-pub"],
        capture_output=True,
        text=True,
        cwd=cwd or None,
    )

    if result.returncode != 0:
        # 解析エラーを stderr に出力（Claude に通知される）
        print("flutter analyze でエラーが検出されました:", file=sys.stderr)
        print(result.stdout, file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
