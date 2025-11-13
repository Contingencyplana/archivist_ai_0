import os, runpy, pathlib

root = pathlib.Path(__file__).resolve().parents[1]
shared_tools = root.parent / "high_command_ai_0" / "tools"

os.environ.setdefault("WORKSPACE_ROOT", str(root))
os.environ.setdefault("WORKSPACE_NAME", root.name)
runpy.run_path(str(shared_tools / "ops_readiness.py"), run_name="__main__")
